# Process/simplify data from seddon 2016 
# 
# 
library(raster)

domain=extent()

# Path to supplementary information
dd="~/Downloads/Variability/"

ppt=raster(file.path(dd,"supporting_files","totPrecProj.grd"))

evi=read.table(file.path(dd,"evi","200002evi.txt"),header=F)[,1]

evim=as.vector(t(matrix(evi, nrow = 3000, byrow = FALSE)))

image(evim)

r_evi=ppt
values(r_evi)=evim
NAvalue(r_evi)=-9999
plot(r_evi)

plot(ppt)
