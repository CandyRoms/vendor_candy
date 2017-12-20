#!/bin/bash

CWD=`pwd`
WIDTH=$1
HEIGHT=$2
RWIDTH=$WIDTH
RHEIGHT=$HEIGHT
HALF_RES=$3
if [ "$HALF_RES" = "true" ]; then
    WIDTH=`expr $WIDTH / 2`
    HEIGHT=`expr $HEIGHT / 2`
fi

if [ -f "/usr/bin/convert" ]; then
if [ -f "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip" ]; then
    echo "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip"
else
RESOLUTION=""$WIDTH"x"$HEIGHT""

mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part{0..3}
tar xvfp "$PWD/vendor/candy/bootanimation/bootanimation.tar" --to-command="convert - -resize '$RESOLUTION' \"png8:$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/\$TAR_FILENAME\""
# create desc.txt
echo "$RWIDTH" "$RHEIGHT" 30 > "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"
cat "$PWD/vendor/candy/bootanimation/desc.txt" >> "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"

# create bootanimation.zip
cd "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation"

if [ ! -d "$ANDROID_PRODUCT_OUT/system/media" ]; then
mkdir -p "$ANDROID_PRODUCT_OUT/system/media"
fi

zip -r0 "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip" .
echo "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip"

fi
fi
