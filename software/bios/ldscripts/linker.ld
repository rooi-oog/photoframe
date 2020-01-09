OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv",
	      "elf32-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)

__DYNAMIC = 0;

MEMORY {
	rom : ORIGIN = 0x00000000, LENGTH = 0x003000		/* ??M ROM */
	ram : ORIGIN = 0x20000000, LENGTH = 0x100000 		/* ??M RAM */
}

SECTIONS
{
	.text :
	{
		_ftext = .;
		*(.text .stub .text.* .gnu.linkonce.t.*)
		_etext = .;
	} > rom

	.rodata :
	{
		. = ALIGN(4);
		_frodata = .;
		*(.rodata .rodata.* .gnu.linkonce.r.*)
		*(.rodata1)
		_erodata = .;
	} > rom

	/* We shouldn't have a .data section, however the GNU crapchain whines if we don't */
	.data :
	{
		. = ALIGN(4);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		_edata = .;
	} > rom
	
	.bss :
	{
		. = ALIGN(4);		
		_fbss = .;
		*(.dynsbss)
		*(.sbss .sbss.* .gnu.linkonce.sb.*)
		*(.scommon)
		*(.dynbss)
		*(.bss .bss.* .gnu.linkonce.b.*)
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
		_end = .;
		PROVIDE (end = .);		
	} > ram
}

PROVIDE(_fstack = ORIGIN(ram) + LENGTH(ram) - 4);
