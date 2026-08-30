https://archive.openwrt.org/releases/25.12.5/targets/x86/64/openwrt-25.12.5-x86-64-generic-ext4-combined.img.gz

# распаковать и конвертировать

"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" convertfromraw --format VDI "c:\Users\Ya\Desktop\owt.img"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" convertfromraw --format VDI "c:\Users\Ya\VirtualBox VMs\OpenWRT_Test\openwrt.img" "c:\Users\Ya\VirtualBox VMs\OpenWRT_TEST\openwrt.vdi"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" convertfromraw --format VDI "c:\Users\Ya\VirtualBox VMs\openwrt-25.12.5-x86-64-generic-ext4-combined.img" "c:\Users\Ya\Desktop\openwrt-25.12.5.vdi"