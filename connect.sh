# /bin/zsh

# unblock wifi
rfkill unblock wifi

# set up the device
ip link set wlp3s0 up

# wpa
wpa_supplicant -B -i wlp3s0 -c wifi.conf

# dhcpcd
dhcpcd wlp3s0

# log out X session first
pkill init

# login as leon
su - leon
