clearvars; close all; clc

%TP1PSB
signalGenerator = SignalGenerator(1e4, -1, 1);
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
%  subplot(3,1,1)
  [t1, f1, sig1_t, sig1_f] = signal1.getSignal();
%   plot(t1, sig1_t)
%   subplot(2,1,2)
% plot(f1, sig1_f)
% xlim([-10 10])
% signalStorage.saveSignal(signal1);
signal1 = signalStorage.loadSignal();
% digitalOperator.listen2signal(signal1)
% signal1 = digitalOperator.idealSample(signal1, 7);
%  signal1 = digitalOperator.naturalSample(signal1, 10, 50);
%  plot(signal1.t,signal1.signal_t)
%  signal1 = digitalOperator.DAC(signal1, 7);
%  subplot(3,1,2)
  plot(signal1.t,signal1.signal_t)
% signal1 = digitalOperator.ADC(signal1, 7);
%    subplot(3,1,3)
%   plot(signal1.t,signal1.signal_t)