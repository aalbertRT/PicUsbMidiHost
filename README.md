# PicUsbMidiHost

Adapted from [soulnafein code](https://github.com/soulnafein/midi-to-cv/).

## General information

### Purpose

This is an MPLAB project that turns a PIC24F chip into a USB MIDI host.

Plug a USB MIDI keyboard to the PIC and get CV / Gate when keys are pressed.

This is ideal for a modular synthesizer.

### HW requirements

This project will work fine for PIC24FJ64GB002 but should also work with PIC24FJ64GB004.

The circuits are based on PIC24FJGB002 family datasheet.

### Outputs

For the moment, there are two outputs: CV and gate.

CV is 1V/oct. The program is configured so a C1 delivers 1V, C2 2V, C3 3V, etc.

Beware, the chip used for this projet is not able to deliver 5V (the datasheet says not more than 2.5V), so you will need a bit of extra circuit to scale PIC voltage output.

## Useful information to a PIC programming beginner

### Tune the internal clock

PIC24FJ64GB002 contains a USB module that allows to programm a usb host or a usb device.

To ensure the USB module works correctly, you need to tune the internal clock thanks to **configuration bits**.

The PIC24FJ64GB002 has all the HW / SW components available to ensure USB module to work, which means you don't need an external crystal to make it work.

First, chose the Fast Internal RC (FRC) Oscillator which initially provides 8MHz clock. To do so, you need to disable the Primary Oscillator (POSC) and select the oscillator source that is used at Power-on-Reset. By selection the FRCPLL option, the oscillator will be the output of the PLL that takes as input the prescaled FRC Oscillator.
=> POSCMOD: NONE (or 11)
=> FNOSC: FRCPLL

Then, turn on 96MHz PLL oscillator at start-up.
=> PLL96MHZ: ON or (1)

The PLL needs a 4MHz input clock to be able to generate a 96MHz output clock. The PRCPLL option for FNOSC already ensures this requirements. It applies a prescaler to the FRC Oscillator to get the 4MHz clock (it divides the FRC frequency by 2). Thus, no prescaler is needed for the PLL input clock:.
=> PLLDIV: NODIV

Finally, the output of the PLL is natively divided by 3 and is scaled by another parameter which is CPDIV. This parameter is not changed so the divider is by default which means the oscillator that provides PIC clock is 32MHz (96MHz / 3).

According to the datasheet, the internal clock is given by the formula FCY = FOSC / 2. The internal clock is then 16MHz.

All this tuning is done in the *system.c* file.


