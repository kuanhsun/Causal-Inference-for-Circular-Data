source('./ipw_estimation_circular.R')

start.time = Sys.time()

HH.250 = simulation.circular(250)
HH.500 = simulation.circular(500)
HH.1000 = simulation.circular(1000)


HC.250 = simulation.circular(250,length = 'constant')
HC.500 = simulation.circular(500,length = 'constant')
HC.1000 = simulation.circular(1000,length = 'constant')

CH.250 = simulation.circular(250,direction = 'constant')
CH.500 = simulation.circular(500,direction = 'constant')
CH.1000 = simulation.circular(1000,direction = 'constant')


end.time = Sys.time()

total.time = end.time-start.time


plot(1:1000,HH.250$mu.ht)
abline(h=1,col = 'red')


plot(1:1000,HH.1000$rho.ht)
abline(h=1/6,col = 'red')


plot(1:1000,HH.250$mu.hajek)
abline(h=1,col = 'red')

plot(1:1000,HH.1000$rho.hajek)
abline(h=1/6,col = 'red')



plot(1:1000,HC.250$mu.ht)
abline(h=1,col = 'red')


plot(1:1000,HC.250$rho.ht)
abline(h=1/6,col = 'red')


plot(1:1000,HC.250$mu.hajek)
abline(h=1,col = 'red')

plot(1:1000,HC.250$rho.hajek)
abline(h=1/6,col = 'red')

###################################
round(table.summary(HH.250[,c(1,3)],1),digits=3)
round(table.summary(HC.250[,c(1,3)],1),digits=3)
round(table.summary(CH.250[,c(1,3)],1),digits=3)

round(table.summary(HH.250[,c(2,4)],1/6),digits=3)
round(table.summary(HC.250[,c(2,4)],1/6),digits=3)
round(table.summary(CH.250[,c(2,4)],1/6),digits=3)


round(table.summary(HH.500[,c(1,3)],1),digits=3)
round(table.summary(HC.500[,c(1,3)],1),digits=3)
round(table.summary(CH.500[,c(1,3)],1),digits=3)

round(table.summary(HH.500[,c(2,4)],1/6),digits=3)
round(table.summary(HC.500[,c(2,4)],1/6),digits=3)
round(table.summary(CH.500[,c(2,4)],1/6),digits=3)


round(table.summary(HH.1000[,c(1,3)],1),digits=3)
round(table.summary(HC.1000[,c(1,3)],1),digits=3)
round(table.summary(CH.1000[,c(1,3)],1),digits=3)

round(table.summary(HH.1000[,c(2,4)],1/6),digits=3)
round(table.summary(HC.1000[,c(2,4)],1/6),digits=3)
round(table.summary(CH.1000[,c(2,4)],1/6),digits=3)


