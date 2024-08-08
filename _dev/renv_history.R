renv::init()

# for code highlighting
renv::install("downlit")
library(downlit)

renv::snapshot()

renv::restore()

renv::status()
