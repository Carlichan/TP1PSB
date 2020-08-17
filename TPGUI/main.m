clearvars; close all; clc

%TP1PSB
signalGenerator = SignalGenerator(1e6, -5, 10);
 [signal_t, signal_f] = signalGenerator.generateSinusoidal(1,10,0);
% subplot(2,1,1)
% plot(signalGenerator.t, signal_t)
% xlim([0 1])
% figure
% subplot(2,1,2)
% plot(signalGenerator.f, signal_f)
signal1 = SignalController(signalGenerator.t,signalGenerator.f, signal_t, signal_f);
signalStorage = SignalStorage();
 digitalOperator = DigitalOperator();
%  subplot(2,1,1)
%  [t1, f1, sig1_t, sig1_f] = signal1.getSignal();
%  plot(t1, sig1_t)
%   subplot(2,1,2)
% plot(f1, sig1_f)
% xlim([-10 10])
% signalStorage.saveSignal(signal1, 0, 2, 1e6);
% signal1 = signalStorage.loadSignal();
%signal1 = digitalOperator.idealSample(signal1, 5);
% signal1 = digitalOperator.naturalSample(signal1, 0.5, 50);
 signal1 = digitalOperator.instantSample(signal1, 50, 50);
 plot(signal1.t,signal1.signal_t)
% %plot(s);