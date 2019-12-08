%MATLAB-YALMIP example implementation of the H2-norm-based LQ Regulation LMI
clc;clear all;close all;
A=[0 1;-1 1];B=[0 1]';x0=[1 0]';
R=1;Q=eye(2);
X=sdpvar(2,2,'full');W=sdpvar(size(B,2),size(B,1),'full');
Y=sdpvar(1);sdpvar gamma;
M1=(A*X+B*W)+(A*X+B*W)'+x0*x0';
M2=trace((Q^0.5)*X*(Q^0.5)')+trace(Y);
M3=[-Y (R^0.5)*W;((R^0.5)*W)' -X];
Constraints=[M1<=0;M2<=gamma;M3<=0];%setup variables and constraints
optimize(Constraints,gamma);%execute problem
K=value(W)*inv(value(X))%display controller matrix