#!/bin/bash

export $(grep -v '^#' ~/.gh_token | xargs -0)

#####################################################################
### Please set the paths accordingly. In case you don't have all  ###
### the listed folders, just keep that line commented out.        ###
#####################################################################
### Path to your config folder you want to backup
config_folder=~/klipper_config

### Path to your Klipper folder, by default that is '~/klipper'
klipper_folder=~/klipper

### Path to your Moonraker folder, by default that is '~/moonraker'
moonraker_folder=~/moonraker

### Path to your Mainsail folder, by default that is '~/mainsail'
mainsail_folder=~/mainsail

### Path to your Fluidd folder, by default that is '~/fluidd'
#fluidd_folder=~/fluidd

#####################################################################
#####################################################################


#####################################################################
################ !!! DO NOT EDIT BELOW THIS LINE !!! ################
#####################################################################
# This function is used to grab the version number from the header file.
# The version number is stored in the VERSION variable.
# The function also prints the version number to the screen.

grab_version(){
  if [ ! -z "$klipper_folder" ]; then # Check if the klipper folder is set
    echo -n "Getting klipper version="
    cd "$klipper_folder"
    klipper_commit=$(git rev-parse --short=7 HEAD)
    m1="Klipper on commit: $klipper_commit"
    echo $klipper_commit
    cd ..
  fi
  if [ ! -z "$moonraker_folder" ]; then # Check if the moonraker folder is set
    echo -n "Getting moonraker version="
    cd "$moonraker_folder"
    moonraker_commit=$(git rev-parse --short=7 HEAD)
    m2="Moonraker on commit: $moonraker_commit"
    echo $moonraker_commit
    cd ..
  fi
  if [ ! -z "$mainsail_folder" ]; then # Check if the mainsail folder is set
    echo -n "Getting mainsail version="
    mainsail_ver=$(head -n 1 $mainsail_folder/.version)
    m3="Mainsail version: $mainsail_ver"
    echo $mainsail_ver
  fi
  if [ ! -z "$fluidd_folder" ]; then # Check if the fluidd folder is set
    echo -n "Getting fluidd version="
    fluidd_ver=$(head -n 1 $fluidd_folder/.version)
    m4="Fluidd version: $fluidd_ver"
    echo $fluidd_ver
  fi
}

# This function pushes the current configuration to the server.
# It also adds a commit message with the version number.
push_config(){
  cd $config_folder
  echo Pushing updates
  git pull -v
  git add . -v
  current_date=$(date +"%Y-%m-%d %T")
  git commit -m "Backup triggered on $current_date" -m "$m1" -m "$m2" -m "$m3" -m "$m4"
#  git push "https://rootiest:$GH_TOKEN@github.com/rootiest/zippy-klipper_config.git"
  git push "git@github.com:rootiest/zippy-klipper_config.git"
}

grab_version
push_config
