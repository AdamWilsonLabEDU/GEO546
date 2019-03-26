#!/bin/bash

# Install R  and friends
# from  https://gist.github.com/mojodna/2f596ca2fca48f08438e
sudo yum -y update
#sudo yum groupinstall "Development Tools" -y    

#  echo "[epel] \n priority=99" >> 
#  echo "echo [epel] >> /etc/yum/pluginconf.d/priorities.conf" | sudo bash
#  echo "echo priority=99 >> /etc/yum/pluginconf.d/priorities.conf" | sudo bash

sudo yum install epel-release
sudo yum update
sudo yum install R -y

#sudo yum --disablerepo "*" --enablerepo "updates" update php
#sudo yum-config-manager --enable epel
#sudo  yum -y install epel-release

sudo yum -y install emacs tcl R make automake gcc gcc-c++ libcurl-devel proj-devel geos-devel openssl-devel tk-devel

# Install GDAL
cd /tmp
curl -L http://download.osgeo.org/gdal/CURRENT/gdal-2.4.0.tar.gz | tar zxf -
cd gdal-2.4.0/
./configure --prefix=/usr/local --without-python
make -j4
sudo make install
cd /usr/local
tar zcvf ~/gdal-2.0.0-amz1.tar.gz *


#install RStudio-Server 
wget https://download2.rstudio.org/rstudio-server-rhel-1.1.463-x86_64.rpm
sudo yum install -y --nogpgcheck rstudio-server-rhel-1.1.463-x86_64.rpm
rm rstudio-server-rhel-1.1.463-x86_64.rpm


# set permissions for R library and documentation
sudo chmod -R g+rwx /usr/lib64/R/library
sudo chmod -R a+rwx /usr/share/doc/


# R packages
# R -e "install.packages('tidyverse', repos='http://cran.rstudio.com/')"
# R -e "install.packages('rgdal', repos='http://cran.rstudio.com/')"
# R -e "install.packages('sf', repos='http://cran.rstudio.com/')"
# R -e "install.packages('httr', repos='http://cran.rstudio.com/')"
# R -e "install.packages('openssl', repos='http://cran.rstudio.com/')"
# R -e "install.packages('devtools', repos='http://cran.rstudio.com/')"

R -e "install.packages(repos='http://cran.rstudio.com/',c('tidyverse','rgdal','sf','httr','openssl','devtools','dismo'))"
R -e "devtools::install_github('wallaceEcoMod/wallace')"



#install shiny and shiny-server 
R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"

wget https://download3.rstudio.org/centos6.3/x86_64/shiny-server-1.5.9.923-x86_64.rpm
sudo yum install -y --nogpgcheck shiny-server-1.5.9.923-x86_64.rpm
rm shiny-server-1.5.9.923-x86_64.rpm

# Shiny setup
mkdir ~/ShinyApps
sudo /opt/shiny-server/bin/deploy-example user-dirs
cp -R /opt/shiny-server/samples/sample-apps/hello ~/ShinyApps/

ln -s /usr/lib/gcc/x86_64-amazon-linux/6.4.1/include/omp.h /usr/local/include/ 
ln -s /usr/lib/gcc/x86_64-amazon-linux/6.4.1/libgomp.spec /usr/lib64/libgomp.spec
ln -s /usr/lib64/libgomp.so.1.0.0 /usr/lib64/libgomp.so

#add user(s)
sudo useradd adamw
echo adamw:adamwaws | sudo chpasswd 

