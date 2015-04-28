#!/bin/sh

set -e

cd /tmp

curl -ssL https://www.haskell.org/ghc/dist/7.8.4/ghc-7.8.4-i386-unknown-linux-deb7.tar.xz | tar xJv
cd ghc-*
./configure && make install
cd ..
rm -rf ghc-*

curl -ssL https://www.haskell.org/cabal/release/cabal-install-1.22.2.0/cabal-install-1.22.2.0.tar.gz | sudo -Hu vagrant tar xzv
cd cabal-install-*
sudo -Hu vagrant ./bootstrap.sh
cd ..
rm -rf cabal-install-*
rm -rf /home/vagrant/.ghc

echo 'export PATH="$PATH:$HOME/.cabal/bin"' >> /home/vagrant/.bashrc

sudo -Hu vagrant /home/vagrant/.cabal/bin/cabal update
sudo -Hu vagrant /home/vagrant/.cabal/bin/cabal install --constraint="haddock==2.15.0.2" alex happy haddock yesod-bin
rm -rf /home/vagrant/.ghc
