# ------------------------------------------------------------------------------------------- #
# Board
CPU			:= rv32i
cpu			:= $(shell echo $(CPU) | tr A-Z a-z)

# ------------------------------------------------------------------------------------------- #
# Programm name
PROG_NAME	:= bios

# where built files will be stored
TARGET_DIR	:= build
TARGET		:= $(PROG_NAME).elf

# Main programm sources
OBJS		+= $(patsubst %.S, %.o, $(shell find -L src -type f -name "*.S"))
OBJS		+= $(patsubst %.c, %.o, $(shell find -L src -type f -name "*.c"))
#OBJS		+= $(patsubst %.c, %.o, $(shell find -L lib -type f -name "*.c"))

# Optimization / debug flags
OPT			:= -Os

# Common C and Linker flags
FLAGS		:= -march=$(CPU) -std=c11
FLAGS		+= -Wstrict-prototypes -Wold-style-definition -Wshadow
FLAGS		+= -Wall -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings
FLAGS		+= -Wredundant-decls -Wstrict-prototypes -Wmissing-prototypes -pedantic #-Werror  

# C compiler flags
CFLAGS		:= $(FLAGS) 

# Linker flags
LDFLAGS		:= -Xlinker --gc-sections
LDSCRIPT	+= -T "linker.ld"
LDFLAGS 	+= -L "ldscripts/" $(LDSCRIPT) -Wl,-Map,"$(TARGET_DIR)/$(PROG_NAME).map"
LDFLAGS		+= --specs=nano.specs

# Include directories
INCLUDE		:= src common lib

# External libraries
LIBS		:= -Wl,--start-group -lgloss -lnosys -lc -lgcc -nostartfiles -Wl,--end-group

# Cross-compile tools
PREFIX		:= riscv32-unknown-elf-
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
	@xxd -e -g4 $(TARGET_DIR)/$(PROG_NAME).bin | xxd -r > $(TARGET_DIR)/$(PROG_NAME)LE.bin
	@../tools/bin2hex $(TARGET_DIR)/$(PROG_NAME)LE.bin $(TARGET_DIR)/$(PROG_NAME).hex 16
	
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
