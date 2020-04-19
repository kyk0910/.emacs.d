#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)
FONT_DIR=$HOME/.local/share/fonts

echo "\n"
echo "1. Install font files"

if [ $(ls -1  $SCRIPT_DIR/../fonts | grep Cica | wc -l) = 4 ]; then
    echo "... Already installed!"
else
    wget https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip $SCRIPT_DIR/fonts
    unzip $SCRIPT_DIR/../fonts/Cica_v5.0.1_with_emoji.zip && rm $SCRIPT_DIR/../fonts/Cica_v5.0.1_with_emoji.zip
    echo "Installed Cica fonts v5.0.1"
fi

mkdir -p $FONT_DIR
ln -sf $SCRIPT_DIR/../fonts/Cica-*.ttf $FONT_DIR

echo "Complete!"

echo "\n"
echo "2. Install dependencies packages"
apt install -y cmake ccache xclip emacs-mozc

echo "Complete!"

echo "\n"
echo "3. Install ccls"
git clone --depth=1 --recursive https://github.com/MaskRay/ccls && cd ccls
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
ccache cmake -j6 -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release --target install
cd ../ && rm -rf ccls

echo "Complete!"

echo "\n"
echo "4. Compile init.el"
emacs --batch -f batch-byte-compile $SCRIPT_DIR/../init.el
emacs --batch -f all-the-icons-install-fonts $SCRIPT_DIR/../init.el

echo "Complete!"
