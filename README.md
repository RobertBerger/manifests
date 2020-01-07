# manifests
manifests for repo tool

## install docker
```
sudo apt install docker.io
sudo usermod -aG docker ${USER}
sudo reboot
```

## install git and the google repo tool
```
sudo apt install git repo

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

## download what's currently on offer
```
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh

chmod +x resy.sh 
./resy.sh 
```

## poky build container
```
./resy-poky-container.sh
```

inside the container

```

```

