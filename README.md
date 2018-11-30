# Digital Photoframe

This is FPGA based digital photoframe project. It capable read jpeg files from SD card and display them to TFT LCD.

### This project utilizes:
* Cyclone IV EP4CE15E22C8 as a heart of whole system
* LatticeMico32 soft-CPU to decode jpeg
* 256Mb SDRAM SDR16 as a framebuffer
* EPCS16 both for configure FPGA and store photoframe's firmware
* Hannstar HDS101PWW2 LVDS display
* FatFs library by [Elm ChaN](http://elm-chan.org/fsw/ff/00index_e.html) 
* TJpegd library by [Elm ChaN](http://elm-chan.org/fsw/tjpgd/00index.html)
	
Most of the code both software and hardware borrowed from [Milkymist(tm)](https://github.com/m-labs/milkymist) project. 
SDRAM controller was borrowed from [Stefan Kristiansson](https://github.com/skristiansson/wb_sdram_ctrl)
SDRAM controller was slightly modified with purpose to give priority to the first master (framebuffer) in case of rivalry.


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
If you're using DE0-Nano development board you'll need Quartus software. Web Edition will be enough.
Then you should upload *pframe.sof* file which is located at *board/de0-nano/syn/output_files* 
or you can upload firmware to the EPCS16 with *epcs16.cdf*. 
Futher you should use *serial_upload* program located at *software/tools* 
to write photoframe's firmare through uart to the device either directly in SDRAM or in EPCS16.

In case if you're using other devices/environments you have to make an effort to force this project work all by yourself. :)
