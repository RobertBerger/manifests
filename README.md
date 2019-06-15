# manifests
manifests for repo tool

## install the google repo tool

## install the Yocto/OE dependencies

https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#required-packages-for-the-build-host

## create a dir where you have plenty of space
```
mkdir -p ~/projects/desire
cd ~/projects/desire
```
## download what's currently on offer
```
wget https://raw.githubusercontent.com/RobertBerger/manifests/master/resy.sh

chmod +x resy.sh 
./resy.sh 
```
## adjust a few things
You might want to adjust the site.conf template for your site:
```
sources/meta-resy/template-common/site.conf.sample
```
