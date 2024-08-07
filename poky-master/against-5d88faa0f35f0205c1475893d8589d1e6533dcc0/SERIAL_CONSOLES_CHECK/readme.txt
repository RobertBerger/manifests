https://patchwork.yoctoproject.org/project/oe-core/patch/20231006112201.1081909-2-ross.burton@arm.com/

https://bugzilla.redhat.com/show_bug.cgi?id=633421

https://0pointer.de/blog/projects/serial-console.html

https://docs.kernel.org/admin-guide/serial-console.html

Note that if you boot without a console= option (or with console=/dev/tty0), /dev/console is the same as /dev/tty0. In that case everything will still work.

busybox:

this works:

#ttyPS0::respawn:/usr/sbin/ttyrun ttyPS0 /sbin/getty 115200 ttyPS0
#ttyO0::respawn:/usr/sbin/ttyrun ttyO0 /sbin/getty 115200 ttyO0
#ttymxc1::respawn:/usr/sbin/ttyrun ttymxc1 /sbin/getty 115200 ttymxc1
console::respawn:/usr/sbin/ttyrun console /sbin/getty 115200 console
#ttymxc0::respawn:/usr/sbin/ttyrun ttymxc0 /sbin/getty 115200 ttymxc0
#ttyS0::respawn:/usr/sbin/ttyrun ttyS0 /sbin/getty 115200 ttyS0
#ttyS2::respawn:/usr/sbin/ttyrun ttyS2 /sbin/getty 115200 ttyS2
#ttySTM0::respawn:/usr/sbin/ttyrun ttySTM0 /sbin/getty 115200 ttySTM0


