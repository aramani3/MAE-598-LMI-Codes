%MATLAB-YALMIP example implementation of the Insensitive Disk Region LMI
clc;clear all;close all;
A=[-1 3 2
   0 1 0
   1 2 -1];
B=[1 0;2 3;1 1];C=[1 1 0];q=4;%setting up paramters for this example
sdpvar gamma;
K=sdpvar(2,1);%setting up variables and matrix to solve
M=[-gamma*eye(size(A,1))    (A+B*K*C+q*eye(size(A,1)));
   (A+B*K*C+q*eye(size(A,1)))'  -gamma*eye(size(A,1))];
Constraints=[M<=0];
optimize(Constraints,gamma)%execute the given problem
gamma=value(gamma)
K=value(K)%display gamma and K matrix values
eta=norm((A+B*K*C+q*eye(size(A,1))),2)%eta is less than or equal to gamma
ApBKC_eig=eig(A+B*K*C)%display the resulting eigenvalues of A+BKC
%Note that all the real part of eigenvalues of A+BKC are negative, hence
%stable.