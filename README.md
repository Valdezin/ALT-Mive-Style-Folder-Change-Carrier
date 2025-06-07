# ALT MIVE Style Folder Change Carrier via Magisk Module

# How this Module Works
This module simply change both `persist.sys.hls.rom.operator` and `sys.hls.rom.operator` to user-desired operator (LG U+, SK Telecom, KT)

# Before Anything Else
- In a very low chance (but not zero) event this module bricks your phone, I am not responsible for any damages, proceed with caution.
- This module is only tested with ALT MIVE Style Folder (AT-M120), any other model is untested.

# Installation
1) Go to [Releases](https://github.com/Valdezin/ALT-Mive-Style-Folder-Change-Carrier/releases) and download the latest .zip file
2) Open Magisk Manager and install this module
3) You will be prompted what carrier would you like to change into (VOL+, VOL-, Side Button ABORT)
4) Reboot the Device and see your new carrier specific bootanimation

Depending on your chosen carrier, you may see new apps installed/removed as other carriers originally shipped it with their proprietary apps.

# Description & Discovery
ALT MIVE Style Folder is a South Korea-exclusive flip phone that runs on Android 12 Go

The phone was exclusive to 3 telecoms in South Korea: LG U+, SK Telecom, and KT

The discovery of these 3 folders named `LGU, SKT, and KT` in the `ROOT` folder `system/media` led me to believe that the bootanimation can be changed if a particular variable is set as such.

Since this is originally a LG U+ device, by using `getprop | grep -i lgu`, I was able to narrow down the variables as:
`thor:/ # getprop | grep -i lgu`

`[persist.sys.hls.rom.operator]: [LGU]`

`[ro.fota.device]: [AT-M120-LGU]`

`[ro.hls.product.vendor.model]: [AT-M120-LGU]`

`[sys.hls.app.density.com.lguplus.mdm.cleanmobile]: [180]`

`[sys.hls.rom.operator]: [LGU]`

The interesting variables here are: `persist.sys.hls.rom.operator` and `sys.hls.rom.operator`, these define what carrier the phone is with.

# LICENSE
Please refer to `LICENSE` for more information.
