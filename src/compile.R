### Compiling biNets with Cleaver

library(rmarkdown)
render('biNets.Rmd')
system('cleaver biNets.md')
system('open biNets-cleaver.html')
system('cleaver watch biNets.md')
