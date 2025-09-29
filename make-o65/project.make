#)              _          (#
#)  ___ ___ _ _|_|___ ___  (#
#) |  _| .'|_'_| |_ -|_ -| (#
#) |_| |__,|_,_|_|___|___| (#
#)        raxiss (c) 2025  (#

# # # # # # # # # # # # # # #

#
PROJECT             := LANDER
PROJECT_VER         := 0.0.1
PROJECT_LABEL       := by [raxiss]
PROJECT_DSK         :=
PROJECT_DSK_TRACKS  := -T42
PROJECT_DSK_AUTORUN := lander
PROJECT_DSK_QUITDOS := 0
PROJECT_DSK_EXCLUDE :=
PROJECT_DSK_INCLUDE :=

#
# EMU                 := emul8
# EMUDIR              :=
EMUPARAM            := -ma
# EMUPARAM            += --turbotape on
# EMUPARAM            += --lightpen on
# EMUPARAM            += --vsynchack on
# EMUPARAM            += --rendermode soft
# EMUPARAM            += --serial none
# EMUPARAM            += --serial loopback
# EMUPARAM            += --serial modem:6502
# EMUPARAM            += --serial com:115200,8,N,1,/dev/ttyUSB0

VPATH               += ..
VPATH               +=

ATAPS               :=
BTAPS               :=
CTAPS               := lander
OTAPS               :=

XXXFLAGS            :=
XXXFLAGS            += -DUSE_ROMCALLS
# XXXFLAGS            += -DUSE_HIRES
# XXXFLAGS            += -DUSE_TEXT
# XXXFLAGS            += -DUSE_VSYNC
# XXXFLAGS            += -DUSE_VSYNC_50HZ
# XXXFLAGS            += -DUSE_VSYNC_60HZ
# XXXFLAGS            += -DUSE_VSYNC_SOFT
# XXXFLAGS            += -DUSE_VSYNC_HARD
# XXXFLAGS            += -DUSE_VSYNC_NEGEDGE
# XXXFLAGS            += -DUSE_VSYNC_AUTO_TEXT
# XXXFLAGS            += -DUSE_JOYSTICK
# XXXFLAGS            += -DUSE_JOYSTICK2
# XXXFLAGS            += -DUSE_JOYSTICK_IJK
# XXXFLAGS            += -DUSE_JOYSTICK_ALTAI
# XXXFLAGS            += -DUSE_LZSA_FAST
# XXXFLAGS            += -DUSE_LZSA_SMALL
# XXXFLAGS            += -DUSE_LZSA_BACKWARD
# XXXFLAGS            += -DUSE_DSND_PERIOD=19996
# XXXFLAGS            += -DUSE_DSND_DELAY=16

# # #
lander_SRC          := compat.s main.c main_asm.s trand.s xprintf.c
lander_ORG          := 0x0600
lander_AUTO         := 1
lander_NAME         :=
lander_DEFS         :=
lander_AFLAGS       := $(XXXFLAGS)
lander_CFLAGS       := $(XXXFLAGS)
lander_LFLAGS       :=

# X_DEFS              += -DUSE_ROMCALLS
# X_DEFS              += -DUSE_VSYNC
# X_DEFS              += -DUSE_VSYNC_50HZ
# X_DEFS              += -DUSE_VSYNC_60HZ
# X_DEFS              += -DUSE_VSYNC_SOFT
# X_DEFS              += -DUSE_VSYNC_HARD
# X_DEFS              += -DUSE_VSYNC_NEGEDGE
# X_DEFS              += -DUSE_VSYNC_AUTO_TEXT
# X_DEFS              += -DUSE_JOYSTICK
# X_DEFS              += -DUSE_JOYSTICK_IJK
# X_DEFS              += -DUSE_JOYSTICK_ALTAI
# X_DEFS              += -DUSE_EMULATOR

X_FLAGS             :=
A_FLAGS             :=
C_FLAGS             :=
L_FLAGS             :=
