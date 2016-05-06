## ----1, results='hide'---------------------------------------------------

M <- c(rep(1,10),
        c(rep(1,4),rep(0,6)),
        c(rep(1,3),rep(0,7)),
        c(rep(1,2),rep(0,8)),
        rep(c(rep(1,1),rep(0,9)),6)
         )
M <- matrix(M,nrow=10)
rownames(M) <- paste('P',1:10,sep='')
colnames(M) <- paste('A',1:10,sep='')


## ----2-------------------------------------------------------------------

M


## ----3-------------------------------------------------------------------

M[sample(1:10,10),sample(1:10,10)]


## ----4-------------------------------------------------------------------

M[sample(1:10,10),sample(1:10,10)]


## ----5-------------------------------------------------------------------

M[sample(1:10,10),sample(1:10,10)]


## ----6-------------------------------------------------------------------
obs <- 45
null <- rnorm(1000,65,9)
hist(null,main='')
abline(v=obs)


## ----7-------------------------------------------------------------------
z.score <- (obs - mean(null)) / sd(null)
p.value <- length(null[null <= obs])/length(null)

z.score
p.value


## ----8, results='hide'---------------------------------------------------

library(bipartite)
data(Safariland)
Safariland


## ----9, echo=FALSE-------------------------------------------------------

Safariland


## ----10------------------------------------------------------------------

plotweb(Safariland)


## ----11------------------------------------------------------------------

plotweb(Safariland,text.rot=90)


## ----12------------------------------------------------------------------

nested(Safariland)


## ----13------------------------------------------------------------------

nested(Safariland,method='ALL')


## ----14------------------------------------------------------------------

safari.nest <- nestedness(Safariland)
names(safari.nest)


## ----15------------------------------------------------------------------

unlist(safari.nest[c('temperature')])
unlist(safari.nest[c('p.null1','p.null2','p.null3')])
unlist(safari.nest[c('mean.temp.null1','mean.temp.null2','mean.temp.null3')])
unlist(safari.nest[c('var.temp.null1','var.temp.null2','var.temp.null3')])


## ----16, echo=FALSE,results='hide'---------------------------------------

if (!(('safari.mods') %in% ls())){safari.mods <- computeModules(Safariland)}


## ----17, eval=FALSE,results='hide'---------------------------------------
## 
## safari.mods <- computeModules(Safariland)
## 

## ----18------------------------------------------------------------------
plotModuleWeb(safari.mods)


## ----19, echo=FALSE, results='hide'--------------------------------------
null.nets <- lapply(1:5,commsimulator,x=Safariland,method='r1')
if (!('null.mods' %in% ls())){null.mods <- lapply(null.nets,computeModules)}
null.stats <- lapply(null.mods,function(x) slot(x,'likelihood'))
null.stats <- unlist(null.stats)


## ----20, eval=FALSE------------------------------------------------------
## null.nets <- lapply(1:5,commsimulator,x=Safariland,method='r1')
## null.mods <- lapply(null.nets,computeModules)
## null.stats <- lapply(null.mods,function(x) slot(x,'likelihood'))
## null.stats <- unlist(null.stats)
## 

## ----21------------------------------------------------------------------
obs.mods <- slot(safari.mods,'likelihood')
null.mu <- mean(null.stats)
null.sd <- sd(null.stats)
null.z <- (obs.mods - null.mu) / null.sd
null.p <- length(null.stats[null.stats <= obs.mods])/length(null.stats)
null.z
null.p


