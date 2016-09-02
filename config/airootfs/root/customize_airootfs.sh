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

### Users
username=normal
useradd -m -g users -G wheel -s /bin/bash $username

### User files
for file in i3 i3status.conf xinitrc Xresources config ssh;
do
    cp -rf /etc/skel/$file /home/$username/.$file
done
chown -R $username:users /home/$username
