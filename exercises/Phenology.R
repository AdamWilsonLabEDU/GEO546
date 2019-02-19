############################################################################
############################# start of code ################################

# load R packages for making graphs
library(tidyverse)
library(cowplot)

# read data 
HF=read_csv(file="exercises/HF_phenology_forR.csv")

# check data
HF

# plot phenology shifts over years with linear regression lines
ggplot(HF,aes(y=bb,x=year))+geom_point()+
  facet_wrap(~SPP,nrow=3)+
  ylab("bud break date (day of year)")+
  stat_smooth(method="lm")

# make scatter plots between phenology and temperature
ggplot(HF,aes(y=bb,x=Tapr))+geom_point()+
  facet_wrap(~SPP,nrow=3)+
  ylab("bud break date (day of year)")+xlab("Mean temperature in April (degree C)")+
  stat_smooth(method="lm")

# make scatter plots between phenology and precipitation
ggplot(HF,aes(y=bb,x=Papr))+geom_point()+
  facet_wrap(~SPP,nrow=3)+
  ylab("bud break date (day of year)")+xlab("Total precipitation in April (mm)")+
  stat_smooth(method="lm")

# linear regression with significance test
rm.bb.t=lm(bb~Tapr,HF[HF$SPP=="red maple",])
summary(rm.bb.t)

rm.bb.p=lm(bb~Papr,HF[HF$SPP=="red maple",])
summary(rm.bb.p)

