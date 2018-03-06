#!/bin/bash

CWD=`pwd`
WIDTH=$1
HEIGHT=$2
RWIDTH=$WIDTH
RHEIGHT=$HEIGHT
HALF_RES=$2
OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

if [ "$HALF_RES" = "true" ]; then
    WIDTH=`expr $WIDTH / 2`
    HEIGHT=`expr $HEIGHT / 2`
fi
RESOLUTION=""$WIDTH"x"$HEIGHT""

mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part{0..3}

tar xfp "$PWD/vendor/candy/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"
mogrify -resize $RESOLUTION -colors 250 "$OUT/bootanimation/"*"/"*".png"

# create desc.txt
echo "$RWIDTH" "$RHEIGHT" 30 > "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"
cat "$PWD/vendor/candy/bootanimation/desc.txt" >> "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"

# create bootanimation.zip
cd "$OUT/bootanimation"
zip -r0 "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation.zip" .
