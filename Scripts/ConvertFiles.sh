#!/bin/bash

mkdir ./Images/converted
# Create the folder to store Next Gen images
mkdir ./Images/converted/jp2
mkdir ./Images/converted/webp
# mkdir ./Images/JXRFiles
mkdir ./Images/converted/Placeholders
mkdir ./Images/converted/jpg

# Go into Image directory for easier understanding
cd Images

# Loop through all images in the Image directory
for file in *; do
  # This means, do not run this code on a directory, only on a file (-f)
  if [[ -f $file ]]; then

    fileName=$(echo $file | cut -d'.' -f 1) # something.jpg -> something

    # Create placeholder and move to Placeholder folder
    # These options are temporary and definitely have room for improvement
    if [[ $file == *.png ]]; then
      # -strip gets rid unnecessary metadata
      # -quality 1 - 100, specifies image quality
      # -resize creates thumbnail like images 4096@ = 64x64 16384@ 128x128
      convert $file -strip -quality 1 -colors 255 -resize 4096@ ./converted/Placeholders/$fileName.png
    else
      convert $file -strip -quality 20 -resize 16384@ ./converted/png/$fileName.jpg
    fi

    # TODO: Need to make images smaller too...

    # Conversion to Next Gen formats, using solely imageMagick defaults

    ## We need to downsize every single file...

    # resize and convert to webp
    convert $file -quality 100 -resize 620x620 ./converted/webp/$fileName-768w.webp
    convert $file -quality 100 -resize 490x490 ./converted/webp/$fileName-1092w.webp
    convert $file -quality 100 -resize 450x450 ./converted/webp/$fileName-2800w.webp

    # resize and convert to jp2
    convert $file -resize 620x620 ./converted/jp2/$fileName-768w.jp2
    convert $file -resize 490x490 ./converted/jp2/$fileName-1092w.jp2
    convert $file -resize 450x450 ./converted/jp2/$fileName-2800w.jp2

    # resize and convert $file to jpg
    convert $file -resize 620x620 ./converted/jpg/$fileName-768w.jpg
    convert $file -resize 490x490 ./converted/jpg/$fileName-1092w.jpg
    convert $file -resize 450x450 ./converted/jpg/$fileName-2800w.jpg

  fi

done

# Go back down
cd ..
