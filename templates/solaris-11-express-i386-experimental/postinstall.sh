# http://projects.puppetlabs.com/projects/1/wiki/Puppet_Solaris

# Add the opencsw package site
export PATH=/usr/bin/:/usr/sbin:$PATH

yes|/usr/sbin/pkgadd -d http://mirror.opencsw.org/opencsw/pkgutil-`uname -p`.pkg all

/opt/csw/bin/pkgutil -U

# yes|/opt/csw/bin/pkgutil -i CSWruby
# used SUNWspro
# has entries in /opt/csw/lib/ruby/1.8/i386-solaris2.9/rbconfig.rb
# luckily there is another one

yes|/opt/csw/bin/pkgutil -i CSWruby18-gcc4
yes|/opt/csw/bin/pkgutil -i CSWruby18-dev

# prevents ":in `require': no such file to load -- mkmf (LoadError)"
yes|/opt/csw/bin/pkgutil -i CSWrubygems

# These are needed to get a compiler working
# Mainly because chef depends on compiling some native gems
export PATH=/opt/csw/bin/:$PATH
export PATH=/opt/csw/gcc4/bin/:$PATH

yes | /opt/csw/bin/pkgutil -i CSWgcc4core
yes | /opt/csw/bin/pkgutil -i CSWgcc4g++
yes | /opt/csw/bin/pkgutil -i CSWreadline
yes | /opt/csw/bin/pkgutil -i CSWzlib
yes | /opt/csw/bin/pkgutil -i CSWossldevel

/opt/csw/bin/gem install puppet  --no-ri --no-rdoc
/opt/csw/bin/gem install chef  --no-ri --no-rdoc

#Installing vagrant keys
mkdir /export/home/vagrant/.ssh
chmod 700 /export/home/vagrant/.ssh
cd /export/home/vagrant/.ssh
/usr/bin/wget --no-check-certificate 'http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /export/home/vagrant/.ssh

#Installing the virtualbox guest additions
VBOX_VERSION=$(cat /export/home/vagrant/.vbox_version)
cd /tmp
/usr/bin/wget http://download.virtualbox.org/virtualbox/4.0.6/VirtualBox-4.0.6-71344-SunOS.tar.gz
/usr/gnu/bin/tar -xzvf VirtualBox-4.0.6-71344-SunOS.tar.gz
/usr/bin/pkgtrans VirtualBox-4.0.6-SunOS-r71344.pkg . all
yes|/usr/sbin/pkgadd -d . SUNWvbox

exit

#Inspiration for ruby enterprise

PATH=$PATH:/opt/csw/bin
wget http://rubyforge.org/frs/download.php/71096/ruby-enterprise-1.8.7-2010.02.tar.gz
tar xzvf ruby-enterprise-1.8.7-2010.02.tar.gz
./ruby-enterprise-1.8.7-2010.02/installer -a /opt/ruby --no-dev-docs --dont-install-useful-gems

# http://www.darkaslight.com/blog/entry/38-Compiling-Ruby-Enterprise-Edition-on-Solaris-10
* To install C compiler:
* To install C++ compiler:
* To install Zlib development headers:
* To install OpenSSL development headers:
* To install GNU Readline development headers:

bash-3.00# wget http://rubyforge.org/frs/download.php/38084/ruby-enterprise-1.8.6-20080507.tar.gz
bash-3.00# gtar xvf ruby-enterprise-1.8.6-20080507.tar.gz
bash-3.00# cd ruby-enterprise-1.8.6-20080507/source
bash-3.00# ./configure --with-openssl-dir=/opt/csw --with-readline-dir=/opt/csw \
--with-iconv-dir=/opt/csw --prefix=/opt/rubyenterprise
bash-3.00# make
bash-3.00# make install