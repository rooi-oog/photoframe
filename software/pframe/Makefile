# ------------------------------------------------------------------------------------------- #
# Board
CPU			:= LM32
cpu			:= $(shell echo $(CPU) | tr A-Z a-z)

# ------------------------------------------------------------------------------------------- #
# Programm name
PROG_NAME	:= pframe

# where built files will be stored
TARGET_DIR	:= build
TARGET		:= $(PROG_NAME).elf

# Main programm sources
OBJS		+= $(patsubst %.S, %.o, $(shell find -L src -type f -name "*.S"))
OBJS		+= $(patsubst %.c, %.o, $(shell find -L src -type f -name "*.c"))
OBJS		+= $(patsubst %.c, %.o, $(shell find -L ../lib -type f -name "*.c"))

# Optimization / debug flags
OPT			:= -O9 -g3

# Common C and Linker flags
FLAGS		:= $(MCPU) $(OPT) -D$(CPU) -std=c11 
FLAGS		+= -Wstrict-prototypes -Wold-style-definition -Wshadow
FLAGS		+= -mbarrel-shift-enabled -mmultiply-enabled -mdivide-enabled
FLAGS		+= -fsigned-char -msign-extend-enabled 
FLAGS		+= -fsingle-precision-constant -Wall -Wextra -Werror 

# C compiler flags
CFLAGS		:= $(FLAGS)

# Linker flags
LDFLAGS		:= -Xlinker --gc-sections
LDSCRIPT	+= -T "linker.ld"
LDFLAGS 	+= -L "ldscripts/" $(LDSCRIPT) -Wl,-Map,"$(TARGET_DIR)/$(PROG_NAME).map"

# Include directories
INCLUDE		:= src ../lib ../common

# External libraries
LIBS		:= -Wl,--start-group -lgloss -lnosys -lc -lgcc -Wl,--end-group

# Cross-compile tools
PREFIX		:= lm32-elf-
CC			:= $(PREFIX)gcc
LD			:= $(PREFIX)gcc

all: bin
	# Disassemling...
	@$(PREFIX)objdump -d --wide $(TARGET_DIR)/$(TARGET) > $(TARGET_DIR)/$(PROG_NAME).asm
	# ---------------------------------------------------------------------------
	# Memory usage
	# ---------------------------------------------------------------------------
	@$(PREFIX)size -A -x $(TARGET_DIR)/$(TARGET)

# Get binary copy
bin: $(TARGET)
	@$(PREFIX)objcopy -O binary $(TARGET_DIR)/$(TARGET) $(TARGET_DIR)/$(PROG_NAME).bin

hex: bin
	@../tools/bin2hex $(TARGET_DIR)/$(PROG_NAME).bin $(TARGET_DIR)/$(PROG_NAME).hex 16
	
$(TARGET): $(OBJS)	
	@$(LD) $(LDFLAGS) -o $(TARGET_DIR)/$@ $^ $(LIBS)

%.o : %.c
	@$(CC) $(CFLAGS) $(addprefix -I, $(INCLUDE)) -o $@ -c $<
	
%.o: %.S
	@$(CC) $(CFLAGS) $(addprefix -I, $(INCLUDE)) -o $@ -c $<	
		
clean:
	@echo "Cleaning..."
	@rm -rf $(OBJS)
	@rm -rf $(TARGET_DIR)/*
	
.PHONY:
	all clean pgm debug
