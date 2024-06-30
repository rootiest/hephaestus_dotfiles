# Copyright (C) 2023 Chris Laprade (chris@rootiest.com)
# 
# This file is part of Hephaestus.
# 
# Hephaestus is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Hephaestus is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Hephaestus.  If not, see <http://www.gnu.org/licenses/>.

#!/bin/bash

# Check if both the source and output filename arguments are provided
if [ $# -lt 2 ]
  then
    echo "Error: Two filenames are required."
    exit 1
fi

# Check if the source file exists
if [ ! -f $1 ] # If the source file does not exist,
  then
    echo "Error: Source file not found." # Report an error
    exit 1
fi

# Extract the filename and extension of the source file
source_filename=$(basename -- "$1") # Extract the filename with extension
source_extension="${source_filename##*.}" # Extract the extension
source_filename="${source_filename%.*}" # Extract the filename

# Create the new filename with the provided output filename and extension of the source file
output_filename=$2 # Set the output filename to the provided output filename
output_extension="${source_extension}" # Set the output extension to the extension of the source file
output_basename=$(basename -- "$2") # Extract the basename of the output filename
output_basename="${output_basename%.*}" # Extract the basename of the output filename
if [ "${output_filename}" = "${output_basename}" ] # If the output filename is the same as the output basename,
  then
    output_filename="${output_filename}.${output_extension}" # Append the output extension to the output filename
fi

# Invert the file
tac $1 > $output_filename # Invert the file

# Confirm successful inversion
if [ $? -eq 0 ] # If the inversion was successful,
  then
    echo "File successfully inverted as $output_filename." # Confirm successful inversion
  else
    echo "Error: Unable to invert file." # Otherwise, report an error
fi
