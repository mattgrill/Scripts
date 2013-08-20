#!/bin/sh
set -e

if [ "$1" == "-h" ]; then
  echo  "     _ ___                _       _         "
  echo  " ___|_|  _|   ___ _ _ ___| |___ _| |___ ___ "
  echo  "| . | |  _|  | -_|_'_| . | | . | . | -_|  _|"
  echo  "|_  |_|_|    |___|_,_|  _|_|___|___|___|_|  "
  echo  "|___|                |_|                    "
  echo  " "
  echo  "./gif-exploder [gif] [output-directory] [scale][not required]"
  echo  " "           
  exit 0
fi


# Temp directory
output=/tmp/gif-exploder
rm -rf $output
mkdir $output

# Frames
mkdir $output/frames
frames=/tmp/gif-exploder/frames

if [[ "${3}" == "" ]]
then
  scale="100%"
else
  scale=$3
fi

# movie!
movie=$1

# get the file name                         
path_explode=(${movie//\// })                                                 
file_name=${path_explode[${#path_explode[@]} - 1]}

# Convert the movie to a gif
convert -quiet -scale $scale $movie $output/gif_temp.gif

# Blow apart the frames
convert $output/gif_temp.gif -coalesce $frames/frame_%03d.gif

# Make a timeline from all the frames and drop it on the desktop
convert +append $frames/frame_*.gif $2/$file_name

# Delete the working directory
rm -rf $output
