%TP1PSB
signalGenerator = SignalGenerator(1e6, -5, 10);
 [signal_t, signal_f] = signalGenerator.generateSinusoidal(1,10,0);
% subplot(2,1,1)
% plot(signalGenerator.t, signal_t)
% subplot(2,1,2)
% plot(signalGenerator.f, signal_f)

%signal1 = SignalController(signalGenerator.t,signalGenerator.f, signal_t, signal_f);
%subplot(2,1,1)
%[t1, f1, sig1_t, sig1_f] = signal1.getSignal();
%plot(t1, sig1_t)
%subplot(2,1,2)
%plot(f1, sig1_f)
%xlim([-10 10])
