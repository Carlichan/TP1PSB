clearvars; close all; clc
%Prueba filtros
fs = 100000;
t = 0:1/fs:10;
x = sin(2*pi*t);
plot(t,x);
hold on;
signalOperator = SignalOperator();
signal  = signalOperator.integrateFilter(x);
plot(t,signal)