%MATLAB-YALMIP example implementation of the D-Stability LMI
clc;clear all;close all;
A=[-5 1 0;0 1 1;1 1 1];
B=[0 0;0 1;1 0];
%set up matrices for this example
P=sdpvar(size(A,1));W=sdpvar(size(B,2),size(B,1),'full');
q=2;r=1;

M=[-r*P q*P+A*P+B*W;q*P+P*A'+W'*B' -r*P];
Constraints=[P>=1e-5*eye(size(A,1));M<=0];%setup constraints
optimize(Constraints);%execute the code
K=value(W)*inv(value(P))%display resulting controller