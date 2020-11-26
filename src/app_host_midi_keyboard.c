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


typedef struct
{
    MIDI_KEYBOARD_STATE state;
    bool inUse;
    uint8_t address;


    MIDI_DEVICE *device;
    //uint8_t buffer[USB_MIDI_PACKET_LENGTH];
    USB_AUDIO_MIDI_PACKET *buffer;

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
    midi_keyboard.state = DEVICE_NOT_CONNECTED;
    midi_keyboard.inUse = false;
    midi_keyboard.device = NULL;
    midi_keyboard.buffer = NULL;
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
    uint8_t currentEndpointIdx;
    
    if (midi_keyboard.device == NULL)
        midi_keyboard.device = USBHostMIDIDeviceDetect();
    
    switch(midi_keyboard.state)
    {            
        case DEVICE_NOT_CONNECTED:
            if (midi_keyboard.device == NULL)
            {
                SYSTEM_Initialize(SYSTEM_STATE_USB_HOST_MIDI_KEYBOARD);
                midi_keyboard.state = DEVICE_CONNECTED;
                TIMER_RequestTick(&APP_HostTimerHandler, 10);
            }
            break;
            
        case DEVICE_CONNECTED:
            break;

        case GET_INPUT_REPORT:
            // Find the Input Endpoint of the keyboard
            for (uint8_t endpointIdx=0; endpointIdx<midi_keyboard.device->numEndpoints; endpointIdx++) {
                // Check it is an IN endpoint
                if (USBHostMIDIEndpointDirection(midi_keyboard.device, endpointIdx)==IN) 
                {
                    currentEndpointIdx = endpointIdx;
                    if (USBHostMIDIRead(midi_keyboard.device,
                                        endpointIdx,
                                        midi_keyboard.buffer,
                                        USB_MIDI_PACKET_LENGTH)) 
                    {
                        // Host may be busy/error -- keep trying
                    } 
                    else 
                    {
                        // USB_SUCCESS received, waiting for TRANSFER_DONE
                        midi_keyboard.state = INPUT_REPORT_PENDING;
                    }                    
                }
            }
            break;

        case INPUT_REPORT_PENDING:
            if(!USBHostMIDITransferIsBusy(midi_keyboard.device, currentEndpointIdx))
            {
                midi_keyboard.state = DEVICE_CONNECTED;
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
    // Process input report received from device */
    if (midi_keyboard.buffer->CIN==MIDI_CIN_NOTE_ON)
    {
        LED_On(LED_USB_HOST_MIDI_KEYBOARD_PAD_PRESSSED);
    }
    else
    {
        LED_Off(LED_USB_HOST_MIDI_KEYBOARD_PAD_PRESSSED);

    }
}

