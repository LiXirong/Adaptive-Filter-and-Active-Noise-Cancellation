% ------------------------------------------------------------------------ 
%  Copyright (C)
%  LiXirong - Wuhan University, China
% 
%  LiXirong <634602068@qq.com> or <lixirong@whu.edu.cn>
%  2018.10.15
% ------------------------------------------------------------------------
% myNLMS.m - Normalized least mean squares algorithm
%
% Usage: [e, y, w] = myLMS(d, x, mu, M, a)
%
% Inputs:
% d  - the vector of desired signal samples of size Ns, �ο��ź�
% x  - the vector of input signal samples of size Ns, �����ź�
% mu - the stepsize parameter, ����
% a  - the bias parameter, ƫ�ò���
% M  - the number of taps. �˲�������
%
% Outputs:
% e - the output error vector of size Ns
% y - output coefficients
% w - filter parameters
%
% ------------------------------------------------------------------------
function [e,y, w] = myNLMS(d, x, mu, M, a)

Ns = length(d);
if (Ns <= M)  
    print('error: �źų���С���˲���������');
    return; 
end
if (Ns ~= length(x))  
    print('error: �����źźͲο��źų��Ȳ�ͬ��');
    return; 
end

x = x; 
xx = zeros( M,1);
w1 = zeros( M,1);
y = zeros(Ns,1);
e = zeros(Ns,1);

for n = 1:Ns
    xx = [xx(2:M);x(n)];
    y(n) = w1' * xx;
    k = mu/(a + xx'*xx);
    e(n) = d(n) - y(n);
    w1 = w1 + k * e(n) * xx;
    w(:,n) = w1;
end
end