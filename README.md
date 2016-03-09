# brewup

##  Why ?
* Manually updating brew is a pain.
* Purging old versions will free up precious disk space.

## What ?
* The cleanup script will execute the update, upgrade and cleanup commands.
* Brew logging will be redirected to /var/log/system.log
* It will run every 3 hours, you can adjust the frequency by unloading the launch daemon, editing the plist and relaunching it.

## Installation
```
curl https://raw.githubusercontent.com/KernelPanicAUS/brewup/master/brewup.sh | bash
```
