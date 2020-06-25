#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)
FONT_DIR=$HOME/.local/share/fonts

echo "\n"
echo "1. Install dependencies packages"
sudo apt update
sudo apt install -y cmake ccache xclip emacs-mozc

echo "Complete!"

echo "\n"
echo "2. Install font files"

cd $SCRIPT_DIR/../fonts
if [ $(ls -1 | grep Cica | wc -l) = 4 ]; then
    echo "... Already installed!"
else
    wget https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip
    unzip Cica_v5.0.1_with_emoji.zip && rm Cica_v5.0.1_with_emoji.zip
    echo "Installed Cica fonts v5.0.1"
fi

mkdir -p $FONT_DIR
cp Cica-BoldItalic.ttf  Cica-Bold.ttf  Cica-RegularItalic.ttf  Cica-Regular.ttf $FONT_DIR

echo "Complete!"

echo "\n"
echo "3. Install ccls"
cd $SCRIPT_DIR/..
git clone --depth=1 --recursive https://github.com/MaskRay/ccls && cd ccls
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
ccache cmake -j6 -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
sudo cmake --build Release --target install

echo "Complete!"
