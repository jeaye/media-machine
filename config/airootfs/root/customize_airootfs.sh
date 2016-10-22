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

cat <<EOF > /etc/profile.d/media-tools.sh
#!/usr/bin/env bash

function setup-network
{
  if ping -q -c1 jeaye.com > /dev/null 2<&1;
  then
    echo "network already setup";
  else
    echo "setting up network";
    ip link set enp32s0 up;
    killall dhcpcd;
    dhcpcd;
  fi
}

function setup-audio
{
  amixer set "Auto-Mute Mode" "Disabled";
  amixer set "Master" "100%";
  alsactl store;
}

function setup-hdmi
{
  xrandr --output HDMI-0 --auto
  xrandr --output LVDS --off
}

function youtube-audio
{
  youtube-dl -o - --audio-quality 0 "\$1" | mpv --no-video -
}

function ssh-mpv
{
  mkdir -p /tmp/ssh-mpv
  sshfs \$1: /tmp/ssh-mpv
  mpv --sub-file /tmp/ssh-mpv/\$3 /tmp/ssh-mpv/\$2
  umount /tmp/ssh-mpv
}
EOF
chmod +x /etc/profile.d/media-tools.sh

### Users
username=root
userhome=/root

### User files
for file in i3 i3status.conf tmux.conf xinitrc Xresources config ssh;
do
    cp -rf /etc/skel/$file $userhome/.$file
done
