#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS
SUB_IMAGE_ADDRESS_COMMAND=--image-address $(SUB_IMAGE_ADDRESS)
else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=bsp/timer_1ms.c bsp/leds.c usb/usb_host.c usb/usb_host_midi.c usb/usb_config.c app_host_midi_keyboard.c main.c system.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/bsp/timer_1ms.o ${OBJECTDIR}/bsp/leds.o ${OBJECTDIR}/usb/usb_host.o ${OBJECTDIR}/usb/usb_host_midi.o ${OBJECTDIR}/usb/usb_config.o ${OBJECTDIR}/app_host_midi_keyboard.o ${OBJECTDIR}/main.o ${OBJECTDIR}/system.o
POSSIBLE_DEPFILES=${OBJECTDIR}/bsp/timer_1ms.o.d ${OBJECTDIR}/bsp/leds.o.d ${OBJECTDIR}/usb/usb_host.o.d ${OBJECTDIR}/usb/usb_host_midi.o.d ${OBJECTDIR}/usb/usb_config.o.d ${OBJECTDIR}/app_host_midi_keyboard.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/system.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/bsp/timer_1ms.o ${OBJECTDIR}/bsp/leds.o ${OBJECTDIR}/usb/usb_host.o ${OBJECTDIR}/usb/usb_host_midi.o ${OBJECTDIR}/usb/usb_config.o ${OBJECTDIR}/app_host_midi_keyboard.o ${OBJECTDIR}/main.o ${OBJECTDIR}/system.o

# Source Files
SOURCEFILES=bsp/timer_1ms.c bsp/leds.c usb/usb_host.c usb/usb_host_midi.c usb/usb_config.c app_host_midi_keyboard.c main.c system.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=24FJ64GB002
MP_LINKER_FILE_OPTION=,--script=p24FJ64GB002.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/bsp/timer_1ms.o: bsp/timer_1ms.c  .generated_files/ed423ad4f0d3fec4ce25bae4868c4e47acac79f8.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/bsp" 
	@${RM} ${OBJECTDIR}/bsp/timer_1ms.o.d 
	@${RM} ${OBJECTDIR}/bsp/timer_1ms.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  bsp/timer_1ms.c  -o ${OBJECTDIR}/bsp/timer_1ms.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/bsp/timer_1ms.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/bsp/leds.o: bsp/leds.c  .generated_files/ab7c91695e36c478f5c1784b35989139ace9b09.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/bsp" 
	@${RM} ${OBJECTDIR}/bsp/leds.o.d 
	@${RM} ${OBJECTDIR}/bsp/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  bsp/leds.c  -o ${OBJECTDIR}/bsp/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/bsp/leds.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/usb/usb_host.o: usb/usb_host.c  .generated_files/d3e83cdf44cf56f4de7e1001578fc28faf213624.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/usb" 
	@${RM} ${OBJECTDIR}/usb/usb_host.o.d 
	@${RM} ${OBJECTDIR}/usb/usb_host.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  usb/usb_host.c  -o ${OBJECTDIR}/usb/usb_host.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/usb/usb_host.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/usb/usb_host_midi.o: usb/usb_host_midi.c  .generated_files/836a5b99ba981ccb68963b8f7ac415d187cf73b1.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/usb" 
	@${RM} ${OBJECTDIR}/usb/usb_host_midi.o.d 
	@${RM} ${OBJECTDIR}/usb/usb_host_midi.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  usb/usb_host_midi.c  -o ${OBJECTDIR}/usb/usb_host_midi.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/usb/usb_host_midi.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/usb/usb_config.o: usb/usb_config.c  .generated_files/b886ba27c736ede229890cddba16e6677eafa03c.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/usb" 
	@${RM} ${OBJECTDIR}/usb/usb_config.o.d 
	@${RM} ${OBJECTDIR}/usb/usb_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  usb/usb_config.c  -o ${OBJECTDIR}/usb/usb_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/usb/usb_config.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/app_host_midi_keyboard.o: app_host_midi_keyboard.c  .generated_files/dbf38c73fd418a2bba572126e7680136d55a440a.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/app_host_midi_keyboard.o.d 
	@${RM} ${OBJECTDIR}/app_host_midi_keyboard.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  app_host_midi_keyboard.c  -o ${OBJECTDIR}/app_host_midi_keyboard.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/app_host_midi_keyboard.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/4470054335009f69e9bc89e4500b62f7fcc3274.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/system.o: system.c  .generated_files/146c8c207901dd08f8bf26265ce0a3072eed1dc.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${RM} ${OBJECTDIR}/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  system.c  -o ${OBJECTDIR}/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/system.o.d"      -g -D__DEBUG     -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/bsp/timer_1ms.o: bsp/timer_1ms.c  .generated_files/8f484a0eac959c27b06bf4bcff5476ff606479d8.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/bsp" 
	@${RM} ${OBJECTDIR}/bsp/timer_1ms.o.d 
	@${RM} ${OBJECTDIR}/bsp/timer_1ms.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  bsp/timer_1ms.c  -o ${OBJECTDIR}/bsp/timer_1ms.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/bsp/timer_1ms.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/bsp/leds.o: bsp/leds.c  .generated_files/78f196d8719e66deedc3deecf10ae54654248f73.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/bsp" 
	@${RM} ${OBJECTDIR}/bsp/leds.o.d 
	@${RM} ${OBJECTDIR}/bsp/leds.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  bsp/leds.c  -o ${OBJECTDIR}/bsp/leds.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/bsp/leds.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/usb/usb_host.o: usb/usb_host.c  .generated_files/f3d036612f4b1357ceb167dd96c1eb97b155b9a6.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/usb" 
	@${RM} ${OBJECTDIR}/usb/usb_host.o.d 
	@${RM} ${OBJECTDIR}/usb/usb_host.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  usb/usb_host.c  -o ${OBJECTDIR}/usb/usb_host.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/usb/usb_host.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/usb/usb_host_midi.o: usb/usb_host_midi.c  .generated_files/3cbc699fbb1f770a17bed1de450b6ba9ecd33b5a.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/usb" 
	@${RM} ${OBJECTDIR}/usb/usb_host_midi.o.d 
	@${RM} ${OBJECTDIR}/usb/usb_host_midi.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  usb/usb_host_midi.c  -o ${OBJECTDIR}/usb/usb_host_midi.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/usb/usb_host_midi.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/usb/usb_config.o: usb/usb_config.c  .generated_files/c88b0319afdd8c523b924cc91a910cf4991791a0.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}/usb" 
	@${RM} ${OBJECTDIR}/usb/usb_config.o.d 
	@${RM} ${OBJECTDIR}/usb/usb_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  usb/usb_config.c  -o ${OBJECTDIR}/usb/usb_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/usb/usb_config.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/app_host_midi_keyboard.o: app_host_midi_keyboard.c  .generated_files/6d27710e89a7fdf09449060b4b1e7adcc5a3f652.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/app_host_midi_keyboard.o.d 
	@${RM} ${OBJECTDIR}/app_host_midi_keyboard.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  app_host_midi_keyboard.c  -o ${OBJECTDIR}/app_host_midi_keyboard.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/app_host_midi_keyboard.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/main.o: main.c  .generated_files/ea538c36b82cffd3690dd6f40dd818b73d47d58c.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  main.c  -o ${OBJECTDIR}/main.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/main.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/system.o: system.c  .generated_files/1e251e0536cf0afd77901bd1205a44e698c6d387.flag .generated_files/1ccb369affb09c8763524c5da5cfbed45d5a7b3a.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${RM} ${OBJECTDIR}/system.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  system.c  -o ${OBJECTDIR}/system.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/system.o.d"        -g -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -O0 -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp"     -Wl,,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--heap=1024,--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -std=c99 -I"usb" -I"bsp" -Wl,,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--heap=1024,--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}/xc16-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/UsbHostMidi.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
