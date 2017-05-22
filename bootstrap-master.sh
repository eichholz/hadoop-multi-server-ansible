#!/bin/bash

sudo -E apt-get update
sudo -E apt-get install -y unzip python-pip python-virtualenv python-dev
sudo -E pip install ansible

chmod 600 /home/vagrant/.ssh/id_rsa
