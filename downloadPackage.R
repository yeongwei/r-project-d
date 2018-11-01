# Returns a vector of dependent packages including the intended package
getDependencies <- function(packs){
  dependencyNames <- unlist(
    tools::package_dependencies(
      packages = packs, db = available.packages(), 
      which = c("Depends", "Imports"), recursive = TRUE))

  packageNames <- union(packs, dependencyNames)
  packageNames
}

args = commandArgs(trailingOnly=TRUE)

# Check that there is at least 1 argument
if (length(args) < 1) stop("Should execute as 'Rscript [--vanilla] downloadPackage.R <packageName> [CRAN repository]'")

r = getOption("repos")

# Check that if explicit CRAN repository URL is provided
if (length(args) == 2) {
  r["CRAN"] = args[2]
} else {
  r["CRAN"] = "http://cran.us.r-project.org"
}

options(repos = r)

# All dependent packages and intended package
fullPackages <- getDependencies(args[1])

workingDirectory <- paste("/tmp/downloadPackage-", format(Sys.time(), "%Y%m%d-%H%M%S"), sep="")
dir.create(workingDirectory)
setwd(workingDirectory)

downloadedPackage <- download.packages(pkgs = fullPackages, destdir = getwd(), type = "source")
downloadedPackage <- rev(basename(downloadedPackage[, 2]))

print(paste(length(downloadedPackage), "package(s) downloaded to", getwd()))

print("")
print("Downloaded the following package(s)")
print(downloadedPackage)

# print("")
# print("Downloaded package(s) will be installed")
# install.packages(downloadedPackage, repos = NULL, type = "source")

