%MATLAB-YALMIP example implementation of the continuous-time D-stability controller.

A = [-1.3410 0.9933 0 -0.1689 -0.2518
    43.2230 -0.8693 0 -17.2510 -1.5766
    1.3410 0.0067 0 0.1689 0.2518
    0 0 0 -20.0000 0
    0 0 0 0 -20.0000];
B = [0 0
    0 0
    0 0
    20 0
    0 20];%matrices that will be used to demonstrate the controller
[~,n]=size(A);[c1,c2]=size(B);
Z=sdpvar(c2,c1);P3=sdpvar(n,n);%initialize the Z and P 
%sdpvar matrices for this problem.
options = sdpsettings('solver','sedumi');
F1=[P3>=1e-5*eye(n)];
ts=6;p_os=0.1;tr=1;r=(1.8/tr);alpha=(4.6/ts);c=(log(p_os)/pi);
F1=[F1,[(-r*P3),(A*P3+B*Z);(A*P3+B*Z)',(-r*P3)]<=1e-5*eye(2*n)];
F1=[F1,A*P3+B*Z+(A*P3+B*Z)'+2*alpha*P3<=1e-5*eye(n)];
F1=[F1,[A*P3+B*Z+(A*P3+B*Z)',c*(A*P3+B*Z-(A*P3+B*Z)');c*((A*P3+B*Z)'-(A*P3+B*Z)),A*P3+B*Z+(A*P3+B*Z)']<=1e-5*eye(2*n)];
optimize(F1,[],options);%execute the given problem
Z=value(Z);P3=value(P3);
K=Z*inv(P3)%display the resulting controller K matrix
ApBK_eig=eig(A+B*K)%display the resulting eigenvalues of A+BK
%Note that all the real part of eigenvalues of A+BK are negative, hence
%stable.
