#!/bin/bash


sudo add-apt-repository 'deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial main '
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 314DF160
sudo apt update
sudo apt install libgdal-dev libproj-dev libgeos-dev libudunits2-dev libv8-dev libcairo2-dev libnetcdf-dev

sudo apt-get  -y update
sudo apt-get  -y install libgdal-dev libcurl4-openssl-dev libgeos-dev libudunits2-dev libv8-dev libcairo2-dev libnetcdf-dev

# Install R
sudo add-apt-repository -y 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo apt update
sudo apt install -y r-base r-base-core r-base-dev r-base-html r-cran-spatial r-doc-html r-recommended

sudo apt install -y r-cran-gstat r-cran-maps r-cran-mapdata r-cran-ncdf4 r-cran-sp r-cran-sf r-cran-sp r-cran-raster r-cran-geor r-cran-ggmap r-cran-leaflet r-cran-rosm
sudo apt install -y r-cran-gstat r-cran-maps r-cran-mapdata r-cran-ncdf4 r-cran-sp r-cran-raster r-cran-geor

#install RStudio-Server 
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb
sudo gdebi -y rstudio-server-1.1.463-amd64.deb

# set permissions for R library and documentation
sudo chmod -R a+rwx /usr/lib64/R/library
sudo chmod -R a+rwx /usr/share/doc/


# R packages
# R -e "install.packages('tidyverse', repos='http://cran.rstudio.com/')"

R -e "install.packages(repos='http://cran.rstudio.com/',c('Rcpp','digest','htmltools','htmlwidgets','rgeos','tidyverse','rgdal','sf','httr','openssl','devtools','dismo'))"
R -e "devtools::install_github('wallaceEcoMod/wallace')"



#install shiny and shiny-server 
sudo su - \
-c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""

wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.9.923-amd64.deb
sudo gdebi -y shiny-server-1.5.9.923-amd64.deb


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

sudo useradd guest
echo guest:rstudio | sudo chpasswd 
