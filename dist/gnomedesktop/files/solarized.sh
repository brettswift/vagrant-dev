
cd
/usr/bin/wget --no-check-certificate https://raw.github.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
mv dircolors.ansi-dark .dircolors
eval `dircolors ~/.dircolors`


# Then, set up Solarized for GNOME Terminal:
# sudo yum install git-core
git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized

# And now you can set it to light or dark using the following commands:
./set_dark.sh
# ./set_light.sh