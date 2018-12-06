#!/bin/bash

CWD=`pwd`
WIDTH=$1
HEIGHT=$WIDTH # our animation is square
RWIDTH=$WIDTH
RHEIGHT=$HEIGHT
HALF_RES=$2
OUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

if [ "$HALF_RES" = "true" ]; then
    WIDTH=`expr $WIDTH / 2`
    HEIGHT=`expr $HEIGHT / 2`
fi
RESOLUTION=""$WIDTH"x"$HEIGHT""

mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/part0

tar xvfp "$PWD/vendor/candy/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"
mogrify -resize $RESOLUTION -colors 250 "$OUT/bootanimation/"*"/"*".png"

# create desc.txt
echo "$RWIDTH" "$RHEIGHT" 25 > "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"
cat "$PWD/vendor/candy/bootanimation/desc.txt" >> "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"

cd "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation"

zip -r0 "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation.zip" .
