#' Install and Load Multiple R Packages
#'
#'Author: Juliano Palacios Abrantes
#'Date: August, 2025
#' This function checks whether the packages listed in the pkg_list are installed. 
#' If any are missing, it installs them from CRAN (including dependencies) and then 
#' loads all packages in the list into the current R session.
#' 
#'@param pkg_list A character vector of package names to be installed (if missing) and loaded.
#' @details
#' The function:
#' \enumerate{
#'   \item Compares \code{pkg_list} against the packages currently installed (via \code{installed.packages()}).
#'   \item Installs any packages not already installed, including their dependencies, from the CRAN mirror at \code{http://cran.us.r-project.org}.
#'   \item Loads all packages in \code{pkg_list} using \code{require()}.
#' }
#'
#' @return 
#' A logical vector (invisibly) indicating the success of loading each package, as returned by \code{sapply()} over \code{require()}.
#'
#' @examples
#' \dontrun{
#' my_load(c("dplyr", "ggplot2", "sf"))
#' }
#'
#' @seealso \code{\link[base]{installed.packages}}, \code{\link[base]{install.packages}}, \code{\link[base]{require}}
#'
#' @export

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

