ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

echo media-machine > /etc/hostname

systemctl enable sshd ; systemctl start sshd

for file in i3 i3status.conf xinitrc Xresources config;
do
    cp -rf /etc/skel/$file ~/.$file
done

#aticonfig --initial
