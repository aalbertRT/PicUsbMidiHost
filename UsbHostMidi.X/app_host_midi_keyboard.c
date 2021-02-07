/*******************************************************************************
Copyright 2016 Microchip Technology Inc. (www.microchip.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

To request to license the code under the MLA license (www.microchip.com/mla_license), 
please contact mla_licensing@microchip.com
*******************************************************************************/
#include "usb.h"
#include "usb_host_midi.h"

#include <stdint.h>
#include <stdbool.h>
#include "system.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// *****************************************************************************
// *****************************************************************************
// Parameters definitions
// *****************************************************************************
// *****************************************************************************
#define MIDI_USB_BUFFER_SIZE           (uint8_t)4 // Used to allocate buffer memory, more than required
#define MIDI_KEYBOARD_ENDPOINT_OUT              0
#define MIDI_KEYBOARD_ENDPOINT_IN               1

// *****************************************************************************
// *****************************************************************************
// Type definitions
// *****************************************************************************
// *****************************************************************************

typedef enum _APP_STATE
{
    DEVICE_NOT_CONNECTED,
    DEVICE_CONNECTED, /* Device Enumerated  - Report Descriptor Parsed */
    GET_INPUT_REPORT, /* perform operation on received report */
    INPUT_REPORT_PENDING,
    ERROR_REPORTED
} MIDI_KEYBOARD_STATE;

typedef enum
{
    READY = 0,
    WAITING
} BUFFER_STATE;

typedef struct
{
    BUFFER_STATE            transferState;      // The transfer state of the endpoint
    uint8_t                 MIDIPacketsNumber;  // Each USB Packet sent from a device has the possibility of holding more than one MIDI packet,
                                                // so this is to keep track of how many MIDI packets are within a USB packet (between 1 and 16, or 4 and 64 bytes)
    uint8_t                 endpointIdx;        
    USB_AUDIO_MIDI_PACKET*  bufferStart;        // The 2D buffer for the endpoint. There are MIDI_USB_BUFFER_SIZE USB buffers that are filled with numOfMIDIPackets
                                                //  MIDI packets. This allows for MIDI_USB_BUFFER_SIZE USB packets to be saved, with a possibility of up to 
                                                //  numOfMIDIPackets MID packets within each USB packet.
    USB_AUDIO_MIDI_PACKET*  pBufReadLocation;   // Pointer to USB packet that is being read from
    USB_AUDIO_MIDI_PACKET*  pBufWriteLocation;  // Pointer to USB packet that is being written to
} ENDPOINT_BUFFER;

typedef struct
{
    MIDI_KEYBOARD_STATE state;
    MIDI_DEVICE *device;
    ENDPOINT_BUFFER endpointBuffer;
} MIDI_KEYBOARD;

// *****************************************************************************
// *****************************************************************************
// Local Variables
// *****************************************************************************
// *****************************************************************************
static MIDI_KEYBOARD midi_keyboard;

// *****************************************************************************
// *****************************************************************************
// Local Function Prototypes
// *****************************************************************************
// *****************************************************************************
static void App_ProcessInputReport(void);
static void clearBuffer(void);
static unsigned int bufferSize(void);
static void handleMIDIPacket(USB_AUDIO_MIDI_PACKET *);

// *****************************************************************************
// *****************************************************************************
// Functions
// *****************************************************************************
// *****************************************************************************


/*********************************************************************
* Function: static void APP_HostHIDTimerHandler(void)
*
* Overview: starts a new request for a report if a device is connected
*
* PreCondition: None
*
* Input: None
*
* Output: None
*
********************************************************************/
static void APP_HostTimerHandler(void)
{
    if(midi_keyboard.state == DEVICE_CONNECTED)
    {
         midi_keyboard.state = GET_INPUT_REPORT;
    }
}

/*********************************************************************
* Function: void APP_HostHIDMouseInitialize(void);
*
* Overview: Initializes the demo code
*
* PreCondition: None
*
* Input: None
*
* Output: None
*
********************************************************************/
void APP_HostMIDIKeyboardInitialize()
{
    // Initialize state
    midi_keyboard.state = DEVICE_NOT_CONNECTED;
    
    // Initialize device 
    midi_keyboard.device = NULL;
    
    // Initialize endpoint buffer
    midi_keyboard.endpointBuffer.transferState = WAITING;
    midi_keyboard.endpointBuffer.MIDIPacketsNumber = 0;
    midi_keyboard.endpointBuffer.endpointIdx = 0;
    midi_keyboard.endpointBuffer.bufferStart = NULL;
    midi_keyboard.endpointBuffer.pBufReadLocation = NULL;
    midi_keyboard.endpointBuffer.pBufWriteLocation = NULL;
}

/*********************************************************************
* Function: void APP_HostMIDIKeyboardTasks(void);
*
* Overview: Keeps the demo running.
*
* PreCondition: The demo should have been initialized via
*   the APP_HostHIDMouseInitialize()
*
* Input: None
*
* Output: None
*
********************************************************************/
void APP_HostMIDIKeyboardTasks()
{    
    
    switch(midi_keyboard.state)
    {            
        case DEVICE_NOT_CONNECTED:
            if (midi_keyboard.device != NULL)
            {
                // Initialize Timer. Is it useful?
                SYSTEM_Initialize(SYSTEM_STATE_USB_HOST_MIDI_KEYBOARD);
                
                // Change state
                midi_keyboard.state = DEVICE_CONNECTED;
            }
            break;
            
        case DEVICE_CONNECTED:
            midi_keyboard.state = GET_INPUT_REPORT;
            break;

        case GET_INPUT_REPORT:
            clearBuffer();
            if (USBHostMIDIRead(midi_keyboard.device,
                                midi_keyboard.endpointBuffer.endpointIdx,
                                midi_keyboard.endpointBuffer.pBufWriteLocation,
                                bufferSize())==USB_SUCCESS)
            {
                // USB_SUCCESS received, waiting for TRANSFER_DONE
                
                // Change state
                midi_keyboard.state = INPUT_REPORT_PENDING;
                midi_keyboard.endpointBuffer.transferState = WAITING;
            }
            break;

        case INPUT_REPORT_PENDING:
            if(!USBHostMIDITransferIsBusy(midi_keyboard.device, midi_keyboard.endpointBuffer.endpointIdx))
            {
                // Set the memory placement of the next USB MIDI packets to the next block of memory
                midi_keyboard.endpointBuffer.pBufWriteLocation += midi_keyboard.endpointBuffer.MIDIPacketsNumber;
                
                // If the end of the allocated memory is reached, get back to the beginning of the memory
                if(midi_keyboard.endpointBuffer.pBufWriteLocation - midi_keyboard.endpointBuffer.bufferStart >= bufferSize())
                {
                    midi_keyboard.endpointBuffer.pBufWriteLocation = midi_keyboard.endpointBuffer.bufferStart;
                }
                // Change state
                midi_keyboard.state = DEVICE_CONNECTED;
                midi_keyboard.endpointBuffer.transferState = READY;
                
                // Process MIDI data
                App_ProcessInputReport();
            }
            break;

        case ERROR_REPORTED:
            break;

        default:
            break;

    }
}

/****************************************************************************
  Function:
    void App_ProcessInputReport(void)

  Description:
    This function processes input report received from HID device.

  Precondition:
    None

  Parameters:
    None

  Return Values:
    None

  Remarks:
    None
***************************************************************************/
static void App_ProcessInputReport(void)
{    
    // Verify the buffer has some packets to be read
    if (midi_keyboard.endpointBuffer.pBufReadLocation != midi_keyboard.endpointBuffer.pBufWriteLocation)
    {
        // Loop over number of MIDI packets in the buffer endpoint
        for (uint8_t midiPacketIdx = 0; midiPacketIdx < midi_keyboard.endpointBuffer.MIDIPacketsNumber; midiPacketIdx++) 
        {
            // Check if the MIDI packet is filled; move the read pointer to the next midi packet memory location
            if (midi_keyboard.endpointBuffer.pBufReadLocation->Val == 0ul)
            {
                // If there's nothing in this MIDI packet, then skip the rest of the USB packet
                midi_keyboard.endpointBuffer.pBufReadLocation += midi_keyboard.endpointBuffer.MIDIPacketsNumber - midiPacketIdx;
                break;
            }
            else
            {
                // Handle MIDI Packet
                handleMIDIPacket(midi_keyboard.endpointBuffer.pBufReadLocation);
                
                // Move the read pointer to the next midi packet memory location
                midi_keyboard.endpointBuffer.pBufReadLocation++;
            }
        }
        // Check if the end of the USB packets array has been reached
        // If so, get back to the beginning of the USB packets array
        if (midi_keyboard.endpointBuffer.pBufReadLocation - midi_keyboard.endpointBuffer.bufferStart
        >= midi_keyboard.endpointBuffer.MIDIPacketsNumber * MIDI_USB_BUFFER_SIZE)
        {
            midi_keyboard.endpointBuffer.pBufReadLocation = midi_keyboard.endpointBuffer.bufferStart;
        }
    }
}


void initializeEndpointBuffer(uint8_t endpointIdx) {
    // Set the endpointIdx of the buffer as the input buffer that has been found
    midi_keyboard.endpointBuffer.endpointIdx = endpointIdx;
    
    // Number of MIDI packets in the endpoint is the size of the endpoint divided by the size of a MIDI packet
    // It should be 16: (endpoint size 64 bytes) / (midi packet size 4 bytes)
    midi_keyboard.endpointBuffer.MIDIPacketsNumber = 
            USBHostMIDISizeOfEndpoint(midi_keyboard.device, endpointIdx) / sizeof(USB_AUDIO_MIDI_PACKET);

    // Get ready to read data
    midi_keyboard.endpointBuffer.transferState = READY;
    
    // Allocate enough memory to have several midi packets in memory
    // It should allocate 16 bytes * 4 = 64 bytes (512 bits)
    midi_keyboard.endpointBuffer.bufferStart = 
            malloc( sizeof(USB_AUDIO_MIDI_PACKET) * midi_keyboard.endpointBuffer.MIDIPacketsNumber * MIDI_USB_BUFFER_SIZE );
    
    // Set the read and write buffer pointer at the beginning of the allocated memory just above
    midi_keyboard.endpointBuffer.pBufReadLocation = midi_keyboard.endpointBuffer.bufferStart;
    midi_keyboard.endpointBuffer.pBufWriteLocation = midi_keyboard.endpointBuffer.bufferStart;
}

unsigned int bufferSize() {
    return midi_keyboard.endpointBuffer.MIDIPacketsNumber * sizeof(USB_AUDIO_MIDI_PACKET);
}

static void clearBuffer() {
    memset(midi_keyboard.endpointBuffer.pBufWriteLocation, 0x00, bufferSize());
}

void onDeviceAttached(void *data) {
    midi_keyboard.device = data;

    // Find the INPUT endpoint and initialize it
    for(uint8_t endpointIdx = 0; endpointIdx < USBHostMIDINumberOfEndpoints(midi_keyboard.device); endpointIdx++)
    {
        if (USBHostMIDIEndpointDirection(midi_keyboard.device, endpointIdx) == IN)
        {
            initializeEndpointBuffer(endpointIdx);
            // Visual indicator to tell the device has been attached and initialized
            LED_On(LED_USB_HOST_MIDI_KEYBOARD_DEVICE_ATTACHED);
            break;
        }
    }        
}

void onDeviceDetached() {
    // Visual indicator to tell user the device has been detached
    LED_Off(LED_USB_HOST_MIDI_KEYBOARD_DEVICE_ATTACHED);
    
    // Free memory
    free(midi_keyboard.endpointBuffer.bufferStart);    
}

/* That's where the PIC does what you want when it receives a midi packet. */
void handleMIDIPacket(USB_AUDIO_MIDI_PACKET *midiPacket) {
    if ((midiPacket->CIN == MIDI_CIN_NOTE_OFF) || 
            (midiPacket->CIN == MIDI_CIN_NOTE_ON && midiPacket->MIDI_1 == 0))
    {
        LED_Off(LED_USB_HOST_MIDI_KEYBOARD_PAD_PRESSED);
    }
    else if (midiPacket->CIN == MIDI_CIN_NOTE_ON)
    {
        LED_On(LED_USB_HOST_MIDI_KEYBOARD_PAD_PRESSED);
    }
}

/****************************************************************************
  Function:
    bool USB_ApplicationEventHandler( uint8_t address, USB_EVENT event,
                void *data, uint32_t size )

  Summary:
    This is the application event handler.  It is called when the stack has
    an event that needs to be handled by the application layer rather than
    by the client driver.

  Description:
    This is the application event handler.  It is called when the stack has
    an event that needs to be handled by the application layer rather than
    by the client driver.  If the application is able to handle the event, it
    returns true.  Otherwise, it returns false.

  Precondition:
    None

  Parameters:
    uint8_t address    - Address of device where event occurred
    USB_EVENT event - Identifies the event that occured
    void *data      - Pointer to event-specific data
    uint32_t size      - Size of the event-specific data

  Return Values:
    true    - The event was handled
    false   - The event was not handled

  Remarks:
    The application may also implement an event handling routine if it
    requires knowledge of events.  To do so, it must implement a routine that
    matches this function signature and define the USB_HOST_APP_EVENT_HANDLER
    macro as the name of that function.
  ***************************************************************************/

bool USB_HOST_APP_EVENT_HANDLER ( uint8_t address, USB_EVENT event, void *data, uint32_t size )
{
    switch( (int)event )
    {
        /* Standard USB host events ******************************************/
        case EVENT_VBUS_REQUEST_POWER:
        case EVENT_VBUS_RELEASE_POWER:
        case EVENT_HUB_ATTACH:
        case EVENT_UNSUPPORTED_DEVICE:
        case EVENT_CANNOT_ENUMERATE:
        case EVENT_CLIENT_INIT_ERROR:
        case EVENT_OUT_OF_MEMORY:
        case EVENT_UNSPECIFIED_ERROR:
        case EVENT_TRANSFER:
            return true;
            break;

        /* MIDI Class Specific Events ******************************************/        
        case EVENT_MIDI_ATTACH:
            onDeviceAttached(data);
            return true;
            
        case EVENT_MIDI_DETACH:
            onDeviceDetached();
            return true;
        
        case EVENT_MIDI_DEBUG_LED_ON:
            LED_On(LED_USB_HOST_MIDI_KEYBOARD_PAD_PRESSED);
            break;
                
        default:
            break;
    }

    return false;

}

