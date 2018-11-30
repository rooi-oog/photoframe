#!/bin/bash

jpg_ext="jpg";
images=$(find $1 -type f -name "*.[Jj][Pp][Gg]");

if [[ $1" " == " " ]]; then
	echo "usage $0 path-to-images";
	exit;
fi

for file in $images; do	
	# If $file extension is different from "jpg"
	if [[ "${file##*.}" != "$jpg_ext" ]]; then		
		# Check file type and get available extensions
		ext=$(file --extension $file | awk -F":" '{print $2}' | awk -F"/" '{print $2}');
		# If the file is a jpg file
		if [[ "$ext" == "$jpg_ext" ]]; then
			# Replace extension
			filename="${file%.*}";
			mv -i $file $filename".$jpg_ext";
			file=$filename".$jpg_ext";
		fi
	fi

	echo -en "Converting $file file...";
	# -resize: resize to 1280x800 or 800x1280 depending on the -auto-orient
	# -interlace: progressive to baseline
	# -sampling-factor: subsampling to 4:2:0
	# -strip: strip all exif and comments
	convert -auto-orient -resize 1280x800 -interlace none -sampling-factor '2x2,1x1,1x1' -strip $file $file 2>/dev/null
	
	echo "done";
done


