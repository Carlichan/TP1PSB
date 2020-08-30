classdef SignalGenerator %% acá se generan las señales
    properties
        fs
        tlow
        thigh
        t        
        n
        f
    end
        
    methods
        function obj = SignalGenerator( fs_, tlow_, thigh_)
            obj.fs = fs_;
            obj.tlow = tlow_;
            obj.thigh = thigh_;
            obj.t = tlow_:1/fs_:thigh_-(1/fs_);
            obj.n = length(obj.t);
            obj.f =(-obj.n/2:obj.n/2-1)/(thigh_-tlow_);
        end
        
        function signal_t = generateSinusoidal(self, freq , a , phase)
            signal_t = a*sin((2*pi*freq*self.t) + phase ); %% time signal creation
%             signal_f = abs(fftshift(fft(signal_t)));
        end
        function signal_t = generateTriangular(self, freq , a , dc)
            %unitTriangle = a*tripuls(self.t/f,dc/f,0);
             if(self.tlow < 0)
                d = self.tlow:1/freq:self.thigh-(1/self.fs);
                x = a *tripuls(self.t,(1/freq)*dc/100);
                signal_t = pulstran(self.t,d,x,self.fs)+pulstran(-self.t-1/freq,d,x,self.fs);
            else
                d = self.tlow:1/freq:self.thigh-(1/self.fs);
                x = a *tripuls(self.t-(1/freq)*dc/100,(1/freq)*dc/100);
                signal_t = pulstran(self.t,d,x,self.fs);
             end
%              signal_f = abs(fftshift(fft(signal_t)));
        end
        function signal_t = generateSquare(self, freq , a , dc)
            signal_t = a*square(2*pi*self.t*freq ,dc );
%             signal_f = abs(fftshift(fft(signal_t)));
        end
         function signal_t = generateUniformNoise(self , a )
           %ruido uniforme
            signal_t = rand(1, length(self.t)) * a * 2 - a;
%             signal_f = abs(fftshift(fft(signal_t)));
         end
         function signal_t = generatePoissonNoise(self, media ,desvio)
            %ruido gaussiano
            signal_t = media.*randn(1, length(self.t)) + desvio;
%             signal_f = abs(fftshift(fft(signal_t)));
        end
    end
end 
