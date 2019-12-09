%MATLAB-YALMIP example implementation of the H2-norm LMI
clc;clear all;close all;
A=[0 0 1 0;
   0 0 0 1;
   -.101 -.1681 -.04564 -.01075;
   .06082 -2.1407 -.05578 -.1273];
B=[0 0 0;0 0 0;.1179 .1441 .1478;.1441 1.7057 -.7557];
C=[1 0 0 0;0 1 0 0];%setup matrices for this example
X=sdpvar(size(A,1));sdpvar gamma;%variables to be solved
Constraints=[X>=1e-5*eye(size(A,1));A*X+X*A'+B*B'<=0];
Constraints=[Constraints;trace(C*X*C')<=gamma];
optimize(Constraints,gamma);%%execute the code
gamma=value(gamma)%display resulting norm value
X=value(X)%display resulting X matrix