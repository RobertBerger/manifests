# manifests
this is still called manifests, but I removed the `repo` tool.
the manifests can be found in `resy.sh` now.

## install docker
```
sudo apt install docker.io
sudo usermod -aG docker ${USER}
sudo reboot
```

## install git
```
sudo apt install git
```

### git config

```
pushd ~
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/gitconfig
mv gitconfig .gitconfig
popd
```

## create a dir where you have plenty of space
```
mkdir -p ~/projects/resy-playground
cd ~/projects/resy-playground
```

## (convenient) symlink on host
```
sudo ln -sf ~/projects/resy-playground /workdir
```
you might need to fix some permissions

## download what's currently on offer
```
mkdir -p /workdir/sources
pushd /workdir/sources
git clone https://github.com/RobertBerger/manifests.git
popd

cd /workdir
ln -sf sources/manifests/resy.sh resy.sh
chmod +x resy.sh
./resy.sh 
```

pick e.g. `experimental`

## poky build container
```
./resy-poky-container.sh
```

## inside the container
```
source resy-cooker.sh
```
