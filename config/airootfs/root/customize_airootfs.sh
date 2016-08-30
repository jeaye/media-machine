for file in i3 i3status.conf xinitrc Xresources config;
do
    cp -rf /etc/skel/$file ~/.$file
done

#aticonfig --initial
