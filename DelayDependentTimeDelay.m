%MATLAB-YALMIP example implementation of the Delay Dependent Time-Delayed System
clc;clear all;close all;
A=[-1 0 1
   0 2 -1
   2 0 -3];
Ad=[1 0 1
    2 1 1
    0 0 -1];
B=[1 1;1 2;0 1];dbar=0.1;%parameters used for this example
sdpvar beta;
X=sdpvar(size(A,1));W=sdpvar(size(B,2),size(B,1),'full');%setting up variables to be solved in YALMIP
Phi_XW=X*(A+Ad)'+(A+Ad)*X+B*W+W'*B'+dbar*Ad*Ad';%Phi(X,W) function
F=[Phi_XW       dbar*(X*A'+W'*B')       dbar*X*(Ad');
   dbar*(A*X+B*W) -dbar*beta*eye(size(A,1))   zeros(3)
   dbar*Ad*X    zeros(3)                -dbar*(1-beta)*eye(3)];
Constraints=[X>=1e-5*eye(size(A,1));0<=beta<=1];
Constraints=[Constraints;F<=0];
optimize(Constraints);%execute the given problem
W=value(W)
X=value(X)
beta=value(beta)%value is between 0 and 1
K=W*inv(X)%display values determined by the solver
