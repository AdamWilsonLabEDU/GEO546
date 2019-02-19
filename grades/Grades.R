# UBLEARNS API 
# https://developer.blackboard.com/portal/displayApi/Learn?version=3200.0.8
library(tidyverse)
library(httr)
library(jsonlite)
# 
# 
#https://ublearns.buffalo.edu//learn/api/public/v1/courses/?name=GEO104
#https://ublearns.buffalo.edu//learn/api/public/v1/courses/_155271_1/gradebook/columns
# get/update grades: https://ublearns.buffalo.edu//learn/api/public/v1/courses/_155271_1/gradebook/columns/_1178056_1/users

baseurl="https://ublearns.buffalo.edu//learn/api/public/v1/courses/"
courseid="_155271_1"
courseid="_158685_1"
gradepath="/gradebook/columns"

courses <- GET(url = paste0(baseurl,courseid,gradepath))
status_code(courses)
repo_content <- content(courses)



