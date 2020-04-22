This package constitutes an interactive R problem set based on the RTutor package (https://github.com/skranz/RTutor). 

--- A RTutor problem that interactively examines how carbon pricing would reduce emissions in the electricity sector. The analysis is based on "Inferring Carbon Abatement Costs in Electricity Markets: A Revealed Preference Approach using the Shale Revolution" by Joseph A. Cullen, Erin T. Mansur (2016) ---

## 1. Installation

RTutor and this package is hosted on Github. To install everything, run the following code in your R console.
```s
install.packages("RTutor",repos = c("https://skranz-repo.github.io/drat/",getOption("repos")))

if (!require(devtools))
  install.packages("devtools")

devtools::install_github("daniel.dreyer/RTutorCO2ReductionCosts", upgrade_dependencies=FALSE)
```

## 2. Show and work on the problem set
To start the problem set first create a working directory in which files like the data sets and your solution will be stored. Then adapt and run the following code.
```s
library(RTutorCO2ReductionCosts)

# Adapt your working directory to an existing folder
setwd("C:/problemsets/RTutorCO2ReductionCosts")
# Adapt your user name
run.ps(user.name="Jon Doe", package="RTutorCO2ReductionCosts",
       auto.save.code=TRUE, clear.user=FALSE)
```
If everything works fine, a browser window should open, in which you can start exploring the problem set.
