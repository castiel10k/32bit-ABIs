#!/system/bin/sh
# Script by AraafRoyall
# Do not modify a single word from this script!
# The developer is not responsible for any damage caused by using this module
# •••••••••••••••••••••••••••••••••••••••

ui_print "[*] Initializing Setup...."

# Basic Script

if command -v rm > /dev/null 2>&1; then
  rm -rf /$MODPATH/README.md /$MODPATH/LICENSE /$MODPATH/update.json /$MODPATH/changelog.md /$MODPATH/system/vendor/tmp
else
  ui_print "Failed to Remove unwanted files from Module, Skipping..."
fi


if [ ! -d "$MODPATH/system" ]; then
if ! { mkdir -p "$MODPATH/system" || install -d "$MODPATH/system"; }; then
  abort "Failed to create directory: $MODPATH/system/vendor"
fi
fi






# •••••••••••• Basic Script End ••••••••••••••





# Check if /system/build.prop exists
if [ ! -f "/system/build.prop" ]; then
  ui_print "[!] /system/build.prop not found on your Device ,Exiting..."
  exit 1
fi


# main part of the script
ui_print "[*] Creating systemless build.prop"


if ! { cp /system/build.prop /$MODPATH/system/ || cat /system/build.prop > /$MODPATH/system/build.prop || dd if=/system/build.prop of=/$MODPATH/system/build.prop; }; then
  ui_print "Unable to create systemless build.prop by any method"
abort "[!] Something went wrong, exiting..."
else
  
ui_print "[*] Checking installation..."
if [ -f "$MODPATH/system/build.prop" ]; then
    ui_print "[*] Systemless build.prop created"
else
    abort "[!] Something went wrong, exiting..."
fi
fi



# PART 2 For Vendor Props
###############################################
###############################################
###############################################
###############################################

# Check if /system/vendor/build.prop exists
if [ -f "/system/vendor/build.prop" ]; then



if [ ! -d "$MODPATH/system/vendor" ]; then
if ! { mkdir -p "$MODPATH/system/vendor" || install -d "$MODPATH/system/vendor"; }; then
  abort "Failed to create directory: $MODPATH/system/vendor"
fi
fi


  

# main part of the script
ui_print "[*] Creating systemless Vendor build.prop"

if ! { cp /system/vendor/build.prop /$MODPATH/system/vendor/ || \
       cat /system/vendor/build.prop > /$MODPATH/system/vendor/build.prop || \
       dd if=/system/vendor/build.prop of=/$MODPATH/system/vendor/build.prop; }; then
  ui_print "Unable to create systemless vendor build.prop by any method"
  ui_print "[!] Something went wrong, Skipping..."
else
  ui_print "[*] Checking installation..."
  if [ -f "$MODPATH/system/vendor/build.prop" ]; then
    ui_print "[*] Systemless vendor build.prop created"
  else
    ui_print "[!] Something went wrong, Unable to create systemless vendor build.prop by any method.. skipping..."
  fi
fi

else
  ui_print "[!] /system/vendor/build.prop not found on your Device, Skipping..."
fi



ui_print "[*] Additionally providing permissions to make editable by any method"

if command -v chmod > /dev/null 2>&1; then
  chmod 777 /$MODPATH/system/build.prop
chmod 777 /$MODPATH/system/vendor/build.prop
else
  ui_print "Failed to Grant Permission, Skipping..."
fi

#!/bin/bash

# Path to the input file
input_file=/$MODPATH/system/vendor/build.prop
# Path to the output file (you can overwrite the original file if needed)
output_file=/$MODPATH/system/vendor/buildtemp.prop

# Create or clear the output file
> $output_file
chmod 777 /$MODPATH/system/vendor/buildtemp.prop
# Read the file line by line
while IFS= read -r line; do
  # Check if the line starts with "allo"
	if [[ $line == ro.zygote* ]]; then
    # Replace the line with "bye"
    echo "ro.zygote=zygote64_32" >> "$output_file"
	ui_print ro.zygote=zygote64_32
	elif [[ $line == ro.vendor.product.cpu.abilist=* ]]; then
    # Replace the line with "beee"
    echo "ro.vendor.product.cpu.abilist=arm64-v8a,armeabi-v7a,armeabi" >> "$output_file"
	ui_print ro.vendor.product.cpu.abilist=arm64-v8a,armeabi-v7a,armeabi
	elif [[ $line == ro.vendor.product.cpu.abilist32=* ]]; then
    # Replace the line with "beee"
    echo "ro.vendor.product.cpu.abilist32=armeabi-v7a,armeabi" >> "$output_file"
	ui_print ro.vendor.product.cpu.abilist32=armeabi-v7a,armeabi
	else
    # Write the original line to the output file
    echo "$line" >> "$output_file"
	ui_print $line
  fi
done < $input_file

# Optionally, replace the original file with the output file
#mv $output_file $input_file
mv $output_file /system/vendor/build.prop

ui_print "[*] All Done."
    ui_print "[*] Reboot to apply the changes"
    ui_print "[*] All edits to build.prop will be systemlessly performed"
    ui_print "[*] If there is an issue, just disable or uninstall this module and the changes will be reverted"

ui_print "[*] Sucessfully installed"
