#!/bin/bash -eux
# set -o pipefail

export box_url=''

if [ ! -f MSEdge-Win10.box ]; then

  while [ -z "$box_url" ]; do
    echo "Attempting to get latest box url from Microsoft.."
    box_url=$(google-chrome-stable --virtual-time-budget=10000 --headless --disable-gpu --dump-dom https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/ | tr -d '\n' | egrep -o "http[^\'\"]*Vagrant.zip")
  done

  echo "Box url is $box_url"

  wget $box_url

  unzip $(basename $box_url)

  mv MSEdge\ -\ Win10.box MSEdge-Win10.box

  vagrant box add --name modern.ie/msedge.win10.1809.vagrant MSEdge-Win10.box

  rm -i MSEdge-Win10.box

fi
