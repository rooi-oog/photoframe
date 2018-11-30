# Digital Photoframe

This is FPGA base digital photoframe project. It can read jpeg files from SD card and display them to TFT LCD.

#### This project utilizes:
	* Cyclone IV EP4CE15E22C8
	* LatticeMico32 soft-CPU to decode image
	* 256Mb SDRAM SDR16 as a framebuffer
	
Most of code both software and hardware borrowed from [Milkymist(tm)](https://github.com/m-labs/milkymist) project.
SDRAM controller was borrowed from [Stefan Kristiansson](https://github.com/skristiansson/wb_sdram_ctrl)
