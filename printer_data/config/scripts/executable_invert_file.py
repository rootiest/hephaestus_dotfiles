#!/usr/bin/env python
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


# Import the required modules
import sys
import os
import subprocess

# Check if both the source and output filename arguments are provided
if len(sys.argv) < 3:
    print("Error: Two filenames are required.")
    sys.exit(1)

# Check if the source file exists
if not os.path.isfile(sys.argv[1]): # If the source file does not exist,
    print("Error: Source file not found.") # Report an error
    sys.exit(1)

# Extract the filename and extension of the source file
source_filename = os.path.basename(sys.argv[1]) # Extract the filename with extension
source_extension = os.path.splitext(source_filename)[1][1:] # Extract the extension
source_filename = os.path.splitext(source_filename)[0] # Extract the filename

# Create the new filename with the provided output filename and extension of the source file
output_filename = sys.argv[2] # Set the output filename to the provided output filename
output_extension = source_extension # Set the output extension to the extension of the source file
output_basename = os.path.basename(output_filename) # Extract the basename of the output filename
output_basename = os.path.splitext(output_basename)[0] # Extract the basename of the output filename
if output_filename == output_basename: # If the output filename is the same as the output basename,
    output_filename = output_filename + "." + output_extension # Append the output extension to the output filename

# Invert the file
subprocess.call(["tac", sys.argv[1], ">", output_filename]) # Invert the file

# Confirm successful inversion
if subprocess.call(["echo", "File successfully inverted as " + output_filename + "."], shell=True) == 0: # If the inversion was successful,
    print("File successfully inverted as " + output_filename + ".") # Confirm successful inversion
else:
    print("Error: Unable to invert file.") # Otherwise, report an error