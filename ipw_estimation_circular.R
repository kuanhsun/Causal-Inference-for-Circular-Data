require(circular)


rwc = function(mu,rho){
  temp = c()
  n = length(mu)
  for(i in 1:n){
    temp = c(temp, rwrappedcauchy(1,mu = mu[1],rho = rho[1]))
  }
  return(temp)
}


estimates = function(theta, weight1,weight0){
  alpha1 = sum(weight1*cos(theta))
  alpha0 = sum(weight0*cos(theta))
  beta1 = sum(weight1*sin(theta))
  beta0 = sum(weight0*sin(theta))
  
  mu.hat = atan2(beta1,alpha1) - atan2(beta0,alpha0)
  rho.hat = sqrt(alpha1^2+beta1^2) - sqrt(alpha0^2+beta0^2)
  
  return(c(mu.hat,rho.hat))
}


coverage = function(sim,true.value){
  stdev = apply(sim,2,sd)
  cover = apply(true.value>sim-1.96*stdev &true.value<sim+1.96*stdev,2,mean  )
  return(cover)
}


table.summary = function(sim,true.value){
  bias = apply(sim-true.value,2,mean)
  sd = apply(sim,2,sd)
  MSE = apply((sim-true.value)^2,2,mean)
  coverage = coverage(sim,true.value)
  
  return(data.frame(bias = bias, sd = sd, MSE = MSE, coverage = coverage))
}



simulation.circular = function(n,rep = 1000, direction = 'hetero',length = 'hetero'){
  
  estimates.ht =c()
  
  estimates.hajek = c()
  
  
  for(i in 1:rep){
    
    X1 = rbeta(n,shape1 = 2,shape2 = 1)
    X2 = rbeta(n,shape1 = 2,shape2 = 1)
    X3 = rbeta(n,shape1 = 2,shape2 = 1)
    
    
    A = rbinom(n,1,prob = exp(1+X1+X2+X3)/ (1+exp(1+X1+X2+X3)))
    
    
    if(direction == 'hetero' & length  == 'hetero'){
      Y1 = rwc(X1+X2+X3,(X1+X2+X3)/3)
      Y0 = rwc((X1+X2+X3)/2,(X1+X2+X3)/4)
    }else if(direction == 'hetero' & length == 'constant'){
      Y1 = rwc(X1+X2+X3,rep(5/6,n))
      Y0 = rwc((X1+X2+X3)/2,rep(2/3,n))
    }else if(direction == 'constant' & length == 'hetero'){
      Y1 = rwc(rep(1,n),(X1+X2+X3)/3)
      Y0 = rwc(rep(0,n),(X1+X2+X3)/4)
    }

    
    Y = A*Y1 + (1-A)*Y0
    
    
    propensity = glm(A~X1+X2+X3,family = 'binomial')$fitted.values
    
    w1.ht = A/propensity/n
    
    w0.ht = (1-A)/(1-propensity)/n
    
    w1.hajek = w1.ht/sum(w1.ht)
    
    w0.hajek = w0.ht/sum(w0.ht)
    
    estimates.ht = rbind(estimates.ht,estimates(Y,w1.ht,w0.ht))
    
    estimates.hajek = rbind(estimates.hajek, estimates(Y,w1.hajek,w0.hajek))
    
  }
  temp = data.frame(cbind(estimates.ht,estimates.hajek))
  colnames(temp) = c('mu.ht','rho.ht','mu.hajek','rho.hajek')
  return(temp)
}