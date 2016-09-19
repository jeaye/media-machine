### Language and region
sed -i 's/^#\(en_US.UTF-8 UTF-8\)/\1/g' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

### System info
echo meter > /etc/hostname

### Services
systemctl enable sshd ; systemctl start sshd

#aticonfig --initial

cat <<EOF > /etc/profile.d/media-tools.sh
#!/usr/bin/env bash

function setup-network
{
  ip link set enp32s0 up;
  killall dhcpcd;
  dhcpcd;
}

function setup-audio
{
  amixer set "Auto-Mute Mode" "Disabled";
  amixer set "Master" "100%";
  alsactl store;
}

function youtube-audio
{
  youtube-dl -o - --audio-quality 0 "\$1" | mpv --no-video -
}

function ssh-mpv
{
  ssh "$1" "cat $2" | mpv -
}
EOF

### Users
username=root
userhome=/root
#useradd -m -g users -G wheel -s /bin/bash $username

### User files
for file in i3 i3status.conf tmux.conf xinitrc Xresources config ssh;
do
    cp -rf /etc/skel/$file $userhome/.$file
done
#chown -R $username:users /home/$username
