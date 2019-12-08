%MATLAB-YALMIP example implementation of the Insensitive Strip Region LMI
clc;clear all;close all;
A=[-0.5 0 1
   0 -2 0
   0 0 -5];
B=[5 3;6 5;7 6];C=[2 -2 1];%setting up paramters for this example
sdpvar gamma;
K=sdpvar(2,1);%setting up variables and matrix to solve
M=(A+B*K*C)'+(A+B*K*C);
Constraints=[M<=gamma*eye(size(A,1))];
optimize(Constraints,gamma)%execute the given problem
gamma=value(gamma)
K=value(K)%display gamma and K matrix values
ApBKC_eig=eig(A+B*K*C)%display the resulting eigenvalues of A+BKC
%Note that all the eigenvalues of A+BKC are negative (and real), hence
%stable.