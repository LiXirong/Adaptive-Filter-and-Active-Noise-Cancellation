% ------------------------------------------------------------------------ 
%  Copyright (C)
%  LiXirong - Wuhan University, China
% 
%  LiXirong <634602068@qq.com> or <lixirong@whu.edu.cn>
%  2018.12.21
% ------------------------------------------------------------------------
% demo3.m - ����Ӧ�˲��㷨���ܱȽ�
% Including LMS��NLMS��RLS algorithm
% Including��
%     1����ͬ�������˲��������������߶Ա�
%     2����ͬ������LMS�㷨��NLMS�㷨�˲���Ȩ�ظ������߶Ա�
% Parameters��
%     x     �� input signal      �����ź�
%     d     �� reference signal  �ο��ź�
%     y     �� output signal     ����ź�
%     e     �� error signal      ����ź�
%     mu    �� LMS stepsize      LMS�㷨����
%     mu2   �� NLMS stepsize     NLMS�㷨����
%     a     �� NLMS bias         NLMS�㷨ƫ�ò���
%     lamda �� RLS weight        RLS�㷨Ȩ��
%
% ------------------------------------------------------------------------
close all;clear;clc;

%% audio + single frequency noise ����Ƶ+��Ƶ������
% [d,fs] = audioread('handel.wav');
% n = length(d);
% T = n/fs;
% t = 0:1/fs:T-1/fs;
% noise = cos(2*pi*t*700)';
% x = d + noise;

%% single frequency signal + white noise ����Ƶ+��������
fs = 8000;
t = 0:1/fs:2;
noise = wgn(length(t),1,-20);
d = cos(2*pi*t*723)' + sin(2*pi*t*456)';
x = noise + d;

%% LMS\NLMS\RLS���ܱȽ�

% set parameters (���ò���)
mu =  [0.0005 0.001 0.005 0.01];
mu2 = [0.005 0.01 0.05 0.1];
a = 0.01;
lamda = [1 0.9999 0.999 0.99];
M = 20;

% �����˲������һ�������ı仯����
figure(1);
for i = 1:length(mu)
    [e1, ~, w1] = myLMS(d, x, mu(i), M);
    c1(i) = {['\mu = ',num2str(mu(i))]};
    subplot(2,1,1)
    plot(w1(M,:)','LineWidth', 1)
    hold on
    subplot(2,1,2)
    plot(e1)
    hold on
end
subplot(2,1,1)
legend(c1)
title('��ͬ������LMS�㷨�˲��������������,M=20')
subplot(2,1,2)
legend(c1)
title('��ͬ������LMS�㷨����������,M=20')

figure(2) 
for i = 1:length(mu2)
    [e2, ~, w2] = myNLMS(d, x,mu2(i), M, a);
    c2(i) = {['\mu = ',num2str(mu2(i))]};
    subplot(2,1,1)
    plot(w2(M,:)','LineWidth', 1)
    hold on
    subplot(2,1,2)
    plot(e2)
    hold on
end
subplot(2,1,1)
legend(c2)
title('��ͬ������NLMS�㷨�˲��������������,M=20')
subplot(2,1,2)
legend(c2)
title('��ͬ������NLMS�㷨����������,M=20')

figure(3)
for i = 1:length(lamda)
    [e3, ~, w3] = myRLS(d, x,lamda(i),M);
    c3(i) = {['\lambda = ',num2str(lamda(i))]};
    subplot(2,1,1)
    plot(w3(M,:)','LineWidth', 1)
    hold on
    subplot(2,1,2)
    plot(e3)
    hold on
end
subplot(2,1,1)
legend(c3)
title('��ͬȨ�ص�RLS�㷨�˲��������������,M=20')
subplot(2,1,2)
legend(c3)
title('��ͬȨ�ص�RLS�㷨����������,M=20')

figure(4)
[e1, ~, w1] = myLMS(d, x, 0.001, M);
[e2, ~, w2] = myNLMS(d, x, 0.01, M, a);
[e3, ~, w3] = myRLS(d, x, 0.9999,M);
subplot(2,1,1)
plot(w2(M,:)','LineWidth', 1);
hold on
plot(w1(M,:)','LineWidth', 1);
plot(w3(M,:)','LineWidth', 1);
legend({'NLMS','LMS','RLS'})
title('�˲���������������Աȣ�\mu1 = 0.001, \mu2 = 0.01, \lambda = 0.9999,M=20')
subplot(2,1,2)
plot(e2);
hold on
plot(e1);
plot(e3);
legend({'NLMS','LMS','RLS'})
title('�����������Աȣ�\mu1 = 0.001, \mu2 = 0.01,\lambda = 0.9999,M=20')
