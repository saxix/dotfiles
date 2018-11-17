#!/bin/bash

sudo find /var/log/ -name *.old -o -name "*.[1,2,3,4,5,6,7,8,9]" | xargs sudo rm
sudo find $HOME/logs/ -name *.old -o -name "*.[1,2,3,4,5,6,7,8,9]" | xargs sudo rm


