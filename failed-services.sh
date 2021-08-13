#!/bin/bash

echo "Failed services: 
"

systemctl list-units --type service | grep failed | awk '{print $2}'

read -p '
Please choose a service to review and type it in the prompt: ' service

systemctl status $service | more

read -p '
Restart the selected service? (y/n) ' yn1

if [ "$yn1" == "y" ]; then
systemctl restart $service
else
read -p '
Review the selected services status again? (y/n) ' yn2
fi

if [ "$yn2" == "y" ]; then
  systemctl status $service | more
else
exit 0
fi

