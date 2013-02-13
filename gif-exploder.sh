#!/bin/sh

#     .d8888b.  8888888 8888888888      8888888888                   888               888                  
#    d88P  Y88b   888   888             888                          888               888                  
#    888    888   888   888             888                          888               888                  
#    888          888   8888888         8888888    888  888 88888b.  888  .d88b.   .d88888  .d88b.  888d888 
#    888  88888   888   888             888        `Y8bd8P' 888 "88b 888 d88""88b d88" 888 d8P  Y8b 888P"   
#    888    888   888   888             888          X88K   888  888 888 888  888 888  888 88888888 888     
#    Y88b  d88P   888   888             888        .d8""8b. 888 d88P 888 Y88..88P Y88b 888 Y8b.     888     
#     "Y8888P88 8888888 888             8888888888 888  888 88888P"  888  "Y88P"   "Y88888  "Y8888  888     
#                                                           888                                             
#                                                           888                                             
#                                                           888                                             

# Examples
# gif-exploder [movie] [scale][not required]
# gif-exploder plane.avi 50%
# gif-exploder plane.avi 

set -e

# Temp directory
output=/tmp/gif-exploder
rm -rf $output
mkdir $output

# Frames
mkdir $output/frames
frames=/tmp/gif-exploder/frames

if [[ "${2}" == "" ]]
then
  scale="100%"
else
  scale=$2
fi

# movie!
movie=$1

# Convert the movie to a gif
convert -quiet -scale $scale $movie $output/gif_temp.gif

# Blow apart the frames
convert $output/gif_temp.gif -coalesce $frames/frame_%03d.gif

# Make a timeline from all the frames and drop it on the desktop
convert +append $frames/frame_*.gif ~/desktop/gif-exploder.jpg

# Delete the working directory
rm -rf $output
