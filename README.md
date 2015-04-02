boa
===

Fork of http://www.boa.org/

Bug fixed.

Can run as a service under systemd.


### Cross compilation in Ubuntu

Take `BeagleBone Black` as an example.

First, you need to install `gcc-arm-linux-gnueabi` in Ubuntu: 

	sudo apt-get install gcc-arm-linux-gnueabi

Clone the code. And
	
	cd boa/src
	./configure

Modify `Makefile` and change two `gcc`s into `arm-linux-gnueabi-gcc`. Then type `make`.

### Installation

You can run `install.sh` as root simply. The script will do the following steps: 

* mkdir:
	* `/etc/boa`
	* `/var/log/boa`
	* `/var/www`
	* `/usr/lib/cgi-bin`
	* `/usr/lib/boa`
* Copy `boa` into `/usr/local/bin`
* Copy `boa_indexer` into `/usr/boa`
* Copy `boa.conf` into `/etc/boa`.
* Make sure that `/etc/mime.types` is available.
* If `systemd` is detected, register `boa.service` (copy it into `/lib/systemd/system`).

### About systemd

Make sure that `/lib/systemd/system/boa.service` exists.

If you want to start boa, you can try:
	
	systemctl start boa

If you want it to start automatically, you can use:
	
	systemctl enable boa
