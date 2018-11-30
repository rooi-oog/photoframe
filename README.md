# Digital Photoframe

This is FPGA base digital photoframe project. It capable read jpeg files from SD card and display them to TFT LCD.

### This project utilizes:
* Cyclone IV EP4CE15E22C8 as a heart of whole system
* LatticeMico32 soft-CPU to decode image
* 256Mb SDRAM SDR16 as a framebuffer
* EPCS16 both as configure FPGA and store photoframe firmware
* Hannstar HDS101PWW2 LVDS display
* FatFs by [Elm ChaN](http://elm-chan.org/fsw/ff/00index_e.html) 
* TJpegd library by [Elm ChaN](http://elm-chan.org/fsw/tjpgd/00index.html)
	
Most of the code both software and hardware borrowed from [Milkymist(tm)](https://github.com/m-labs/milkymist) project. 
SDRAM controller was borrowed from [Stefan Kristiansson](https://github.com/skristiansson/wb_sdram_ctrl)

### Limitations:
For this project I'm using 10.1" LCD with 1280x800 screen resolutuion. In order to display various jpeg images 
user should downscale that images to LCD resolutuion. 
Furthermore Tjpegd library capable to decode baseline and 4:2:0 jpegs only. 
For this purpose I wrote small script which located at *software/tools/conv.sh*. 
This script uses ImageMagick for converting all images in given directory to:
- baseline
- 4:2:0 subsambling
- 1280x800 or 800x1280 depending of image orientation

### How to reproduce:

