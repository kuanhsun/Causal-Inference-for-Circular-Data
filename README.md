# Causal Inference for Circular Data
-------------

This page displays the codes for estimating average direction treatment effect (ADTE) and average length treatment effect (ALTE).

* Paper Reference: [Causal Inference for Circular Data](https://github.com/kuanhsun/Causal-Inference-for-Circular-Data/blob/main/Causal_Inference_for_Circular_Data_0726.pdf)
* Contact: Kuan-Hsun Wu, email: 110304015@g.nccu.edu.tw
-------------
## ipw_estimation_circular.R
The functions are recorded in this code. 

### rwc
```rwc = function(mu,rho)```
* Generate wrapped Cauchy variate.
* Inputs:
  - mu: Mean Direction. A vector of length $n$.
  - rho: Mean Length. A vector of length $n$.
* Outputs:
  - A vector whose length is same as mu. The $i$ th entry in the vector is a wrapped Cauchy variate generated with mean direction using $i$ th item of mu and mean length using $i$ th item of rho.

### estimates
```estimates = function(theta, weight1,weight0)```
* Produce the estimates.
* Inputs:
  - theta: The circular outcome.
  -  weight1: The weight for one of the counterfactual variables.
  -  weight0: The weight for the other counterfactual variable.
* Outputs:
  - A vector containing the estimates of ADTE and ALTE using the specified weight.
 
### coverage
```coverage = function(sim,true.value)```
* Calculate the coverage probability of a simulation run.
* Inputs:
  - sim: The simulation outcomes
  - true.value: The pre-determined true value of the parameter.
* Outputs:
  - The proportion that the estimates of the simulation can capture the true parameter within $95\%$ CI. The standard deviation is taken among all simulation results.
 
### table.summary
```table.summary = function(sim,true.value)```
* Summarize the simulation result. 
* Inputs:
  - sim: The simulation outcomes
  - true.value: The pre-determined true value of the parameter.
* Outputs:
  - bias: The average bias of this simulation run. 
  - sd: The standard deviation of the estimates in this simulation run. 
  - MSE: The mean sqaured error of this simulation run. 
  - coverage: The coverage probabiltity of this simulation run. 
