pacman -S python-pip
sh installUeberzug.sh

git clone https://github.com/dirkvdb/ffmpegthumbnailer.git
cd ~/ffmpegthumbnailer
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_GIO=ON -DENABLE_THUMBNAILER=ON
make
make install
rm -R ~/ffmpegthumbnailer

pip install Pillow
git clone https://github.com/marianosimone/epub-thumbnailer.git
cd ~/epub-thumbnailer
sudo python install.py install
rm -R ~/epub-thumbnailer

pacman -S xodotool
pacman -S fzf
pacman -S imagemagick
pacman -S sxiv

git clone https://github.com/sdushantha/fontpreview
cd fontpreview
sudo make install
