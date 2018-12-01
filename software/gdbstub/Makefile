# ------------------------------------------------------------------------------------------- #
# Board
CPU			:= LM32
cpu			:= $(shell echo $(CPU) | tr A-Z a-z)

# ------------------------------------------------------------------------------------------- #
# Programm name
PROG_NAME	:= gdbstub

# where built files will be stored
TARGET_DIR	:= .
TARGET		:= $(PROG_NAME).elf

# Main programm sources
OBJS		+= $(patsubst %.S, %.o, $(shell find -L -type f -name "*.S"))
OBJS		+= $(patsubst %.c, %.o, $(shell find -L -type f -name "*.c"))

# Optimization / debug flags
OPT			:= -Os

# Common C and Linker flags
FLAGS		:= $(MCPU) $(OPT) -D$(CPU) -std=c11 
FLAGS		+= -Wstrict-prototypes -Wold-style-definition -Wshadow
FLAGS		+= -mbarrel-shift-enabled -mmultiply-enabled -mdivide-enabled
FLAGS		+= -fno-builtin -fsigned-char -msign-extend-enabled 
FLAGS		+= -fsingle-precision-constant -Wall -Wextra #-Werror 

# C compiler flags
CFLAGS		:= $(FLAGS)

# Linker flags
LDFLAGS		:= -Xlinker --gc-sections
LDSCRIPT	+= -T "linker.ld"
LDFLAGS 	+= $(LDSCRIPT) -Wl,-Map,"$(TARGET_DIR)/$(PROG_NAME).map"

# Include directories
INCLUDE		:= src ../common ../lib

# External libraries
LIBS		:= -Wl,--start-group -nostartfiles -nostdlib -nodefaultlibs -Wl,--end-group

# Cross-compile tools
PREFIX		:= lm32-elf-
CC			:= $(PREFIX)gcc
LD			:= $(PREFIX)gcc

all: hex
	# Disassemling...
	@$(PREFIX)objdump -d -S --wide $(TARGET_DIR)/$(TARGET) > $(TARGET_DIR)/$(PROG_NAME).asm
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
	@rm -rf $(TARGET_DIR)/*.asm
	@rm -rf $(TARGET_DIR)/*.bin
	@rm -rf $(TARGET_DIR)/*.hex
	@rm -rf $(TARGET_DIR)/*.map
	@rm -rf $(TARGET_DIR)/*.elf
	
.PHONY:
	all clean pgm debug	

