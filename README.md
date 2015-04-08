boa
===

Fork of http://www.boa.org/

Bug fixed.

Can run as a service under systemd.


## Make boa work

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
* If `systemd` is detected, register `boa.service` (copy it into `/lib/systemd/system` or `/usr/lib/systemd/system`).

### About systemd

Make sure that `/lib/systemd/system/boa.service` (or `/usr/lib/systemd/system/boa.service`) exists.

If you want to start boa, you can try:
	
	systemctl start boa

If you want it to start automatically, you can use:
	
	systemctl enable boa


## Make PHP work

C/Python/Perl/PHP programs can work under BOA as CGI scripts.

Scripts are needed to put in the `cgi-bin` folder and "`x`" permission is required.

If you don't want to do that, you can modify `/etc/boa/boa.conf` and add:

	AddType application/x-httpd-cgi php

("php" can be replaced by other extensions, as you can know, such as py, pl.)

After that, scripts can be placed anywhere.

### php-cgi

**`php-cgi` is recommended for PHP.**

PHP files needs shabang like this:

	#!/usr/bin/php-cgi
	
and "`x`" permission is also necessary.

In addition, a small changed needs to be applied to `php.ini` (may be `/etc/php.ini` or `/usr/lib/php.ini`):

	cgi.force_redirect = 0
	
or `php-cgi` will refuse to execute the scripts.

### no php-cgi

If you use `php` instead of `php-cgi`, you need to output HTTP header yourself, and **$_REQUEST, $_SESSION are not avaliable.**