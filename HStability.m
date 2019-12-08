%MATLAB-YALMIP example implementation of the H-Stability LMI
clc;clear all;close all;
A=zeros(20);
for i=1:20
    A(i,i)=20-i+1;
end
for i=1:19
    A(i+1,i)=20;
end
B=[1 zeros(1,19)]';C=[zeros(1,19) 1];%set up matrices for this example
P=sdpvar(20);W=sdpvar(size(B,2) ,size(B,1),'full');
alpha=1;beta=3;

M=A*P+P*A'+B*W+W'*B'+2*alpha*P;
M2=-(A*P+P*A'+B*W+W'*B')-2*beta*P;
Constraints=[P>=1e-5*eye(size(A,1));M<=0;M2<=0];%setup constraints
optimize(Constraints);%execute the code
K=value(W)*inv(value(P))%display resulting controller
