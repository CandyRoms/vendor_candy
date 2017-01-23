#!/bin/bash

CWD=`pwd`
BASEW=$1 # Device Width
BASEH=$2 # Device Height
HALF_RES=$3 # Half the size of the device resolution (true or false)
PORTW=1400 # Original bootanimation image based on unmodified width
PORTH=2560 # Original bootanimation image based on unmodified height

if [ -f "/usr/bin/convert" ]; then
  if [ -f "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip" ]; then

    echo "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip"

  else

    if [ -d "$ANDROID_PRODUCT_OUT"/obj/BOOTANIMATION/bootanimation/part0 ]; then
      rm -rf "$ANDROID_PRODUCT_OUT"/obj/BOOTANIMATION/bootanimation/part*
    else
      mkdir -p "$ANDROID_PRODUCT_OUT"/obj/BOOTANIMATION/bootanimation/part{0..2}
    fi

    tar xvfp "$CWD/vendor/candy/bootanimation/bootanimation.tar" -C "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/$TAR_FILENAME"

    while read -r line; do
      IMAGEFILE="$(basename "${line}")"
      IMAGEFILEDIR="$(dirname "${line}")"
      # Determine original width and height of each image.
      SIZEW=$(identify -format "%wx%h" "${IMAGEFILEDIR}"/"${IMAGEFILE}" | egrep -o "[0-9]+x" | egrep -o "[0-9]+")
      SIZEH=$(identify -format "%wx%h" "${IMAGEFILEDIR}"/"${IMAGEFILE}" | egrep -o "x[0-9]+" | egrep -o "[0-9]+")
      if [ "$HALF_RES" = "true" ]; then
        # Resize the images by half
        FINALW=$(expr $SIZEW / 2)
        FINALH=$(expr $SIZEH / 2)
        # Make the conversion
        convert "${IMAGEFILEDIR}"/"${IMAGEFILE}" -resize "$FINALW"'x'"$FINALH"'!' "${IMAGEFILEDIR}"/"${IMAGEFILE}"
      else
        # Calculate old size for new size of each image for proper ratio.
        MODW=$(awk "BEGIN{print ${PORTW}/${SIZEW}}")
        NEWW=$(awk "BEGIN{print ${BASEW}/${MODW}}")
        MODH=$(awk "BEGIN{print ${PORTH}/${SIZEH}}")
        NEWH=$(awk "BEGIN{print ${BASEH}/${MODH}}")
        # Round the fractions for each image.
        FINALW=$(awk "BEGIN{print int(${NEWW}+0.5)}")
        FINALH=$(awk "BEGIN{print int(${NEWH}+0.5)}")
        # Make the conversion
        convert "${IMAGEFILEDIR}"/"${IMAGEFILE}" -resize "$FINALW"'x'"$FINALH"'!' "${IMAGEFILEDIR}"/"${IMAGEFILE}"
      fi
    done < <(find "$ANDROID_PRODUCT_OUT"/obj/BOOTANIMATION/bootanimation -type f -iname "*.png" -o -iname "*.jpg")

    # create desc.txt
    echo "$FINALW" "$FINALH" 60 > "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"
    cat "$CWD/vendor/candy/bootanimation/desc.txt" >> "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/desc.txt"

    # create bootanimation.zip
    cd "$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation"

    if [ ! -d "$ANDROID_PRODUCT_OUT/system/media" ]; then
      mkdir -p "$ANDROID_PRODUCT_OUT/system/media"
    fi

    zip -r0 "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip" .
    echo "$ANDROID_PRODUCT_OUT/system/media/bootanimation.zip"

  fi
fi
