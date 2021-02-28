#!/bin/sh

# Add some identification to the log
DEVICE=$(echo $TARGET_PRODUCT | sed -e 's/candy_//g')

# Load color refs
. vendor/candy/tools/colors

# Exports
export Changelog=Changelog.txt

if [ -f $Changelog ];
then
	rm -f $Changelog
fi

touch $Changelog

# Print something to build output
echo ${CL_GRN}"Cooking up the changelog..."${CL_RST}

echo "🍬🍬🍬🍬🍬🍬 CANDY 11 🍬🍬🍬🍬🍬🍬" >> $Changelog;
echo "" >> $Changelog;
echo " CandyRoms Changelog for $DEVICE" >> $Changelog;
echo "" >> $Changelog;
echo "🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬🍬" >> $Changelog;
echo >> $Changelog;

for i in $(seq 14);
do
export After_Date=`date --date="$i days ago" +%d-%b-%Y`
k=$(expr $i - 1)
	export Until_Date=`date --date="$k days ago" +%d-%b-%Y`

	# Line with after --- until was too long for a small ListView
	echo '🍬 '$Until_Date' 🍬' >> $Changelog;
    CURRENT_PATH="$(realpath `pwd`)"
    repo forall -c "GIT_LOG=\`git log --oneline --after=$After_Date --until=$Until_Date --abbrev-commit --abbrev=7 --pretty=format:\"%h %s [%an]\"\` ; if [ ! -z \"\$GIT_LOG\" ]; then printf '\n* '; realpath \`pwd\` | sed 's|^$CURRENT_PATH/||' ; echo \"\$GIT_LOG\"; fi" >> $Changelog
	echo >> $Changelog;
done

sed -i 's/project/   */g' $Changelog
sed -i 's/[/]$//' $Changelog

# Save the log for later use in CandyShop

cp $Changelog $OUT_DIR/target/product/$DEVICE/system/etc/
mv $Changelog $OUT_DIR/target/product/$DEVICE/
