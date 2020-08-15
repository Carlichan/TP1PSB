classdef SignalGenerator %% acá se generan las señales
    properties
        fs
        t        
        n
        f
    end
        
    methods
        function obj = SignalGenerator(fs_, tlow_, thigh_)
            obj.fs = fs_;
            obj.t = tlow_:1/fs_:thigh_-(1/fs_);
            obj.n = length(obj.t);
            obj.f =(-obj.n/2:obj.n/2-1)/(thigh_-tlow_);
        end
        
        function [signal_t, signal_f] = generateSinusoidal(self, freq , a , phase)
            signal_t = a*sin((2*pi*freq*self.t) + phase ); %% time signal creation
            signal_f = abs(fftshift(fft(signal_t)));
        end
        function [signal_t, signal_f] = generateTriangular(self, freq , a , dc)
            %unitTriangle = a*tripuls(self.t/f,dc/f,0);
            d = tlow_:1/freq:thigh_-(1/fs_);
            x = a *tripuls(self.t,(1/freq)*dc/100);
            signal_t = pulstran(self.t,d,x,fs_)+pulstran(-self.t-1/freq,d,x,fs_);
            signal_f = abs(fftshift(fft(signal_t)));
        end
        function [signal_t, signal_f] = generateSquare(self, freq , a , dc)
            signal_t = a*square(2*pi*self.t*freq ,dc );
            signal_f = abs(fftshift(fft(signal_t)));
        end
    end
end 
