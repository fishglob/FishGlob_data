#' Install and Load Multiple R Packages
#'
#' This function checks whether the packages listed in the pkg_list are installed. 
#' If any are missing, it installs them from CRAN (including dependencies) and then 
#' loads all packages in the list into the current R session.
#'


check_pkg <- function(pkg_list){
  new.pkg <- pkg_list[!(pkg_list %in% installed.packages()[,"Package"])]
  
  if(length(new.pkg) >0){ 
    install.packages(new.pkg, dependencies = TRUE, repos = "http://cran.us.r-project.org")
    message(paste0("I have installed the following package(s): ",new.pkg))
  }
  
  suppressMessages(
  sapply(pkg_list, require, character.only = TRUE)
  )
}

