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

#define FCY 16000000

/** INCLUDES *******************************************************/
#include "usb.h"
#include "usb_host_midi.h"

#include "system.h"
#include "app_host_midi_keyboard.h"
#include <libpic30.h>
#include "leds.h"

/********************************************************************
 * Function:        void main(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Main program entry point.
 *
 * Note:            None
 *******************************************************************/
MAIN_RETURN main(void)
{       
    SYSTEM_Initialize(SYSTEM_STATE_USB_HOST);
    
    //Initialize the stack
    USBHostInit(0);
    
    APP_HostMIDIKeyboardInitialize();
    while(1)
    {
        USBHostTasks();
        //Application specific tasks
        APP_HostMIDIKeyboardTasks();
    }
}


