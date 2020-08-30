clearvars; close all; clc
%Prueba cuant
fs = 1e5;
to = -1;
tf = 5;

t= to:1/fs:tf;
x= t.^2;

% x(length(t)-1)

%function quantiz = idealSampler(signal,fs)
%  paso = 1/1e5;


% Quantization

q = 25/32;
y = q*round(x/q);
plot(t,y)
grid on