%MATLAB-YALMIP example implementation of the Delay Independent Time-Delayed System
clc;clear all;close all;
A=[-1 0 1
   0 2 -1
   2 0 -3];
Ad=[1 0 1
    2 1 1
    0 0 -1];
B=[1 1;1 2;0 1];%parameters used for this example
X=sdpvar(size(A,1));W=sdpvar(size(B,2),size(B,1),'full');
Y=sdpvar(size(A,1));%setting up variables to be solved in YALMIP
F=[X*A'+A*X+B*W+W'*B'+Y     Ad*X;
   X*Ad'                    -Y];
Constraints=[X>=1e-5*eye(size(A,1));Y>=1e-5*eye(size(A,1))];
Constraints=[Constraints;F<=0];
optimize(Constraints);%execute the given problem
W=value(W)
X=value(X)
Y=value(Y)
K=W*inv(X)%display values determined by the solver
