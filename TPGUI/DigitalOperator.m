classdef DigitalOperator
    properties
        
    end
    methods
        
        function signal = idealSample(obj, signal, fs) % ACA SE PRODUCE EL MUESTREO IDEAL                        
            paso = 1/1e6;              
            tstem = zeros(1,length(signal.signal_t));
            i = 1;
            while i<length(signal.signal_t)
                tstem(i) = 1;
                i = i+ cast(1/(fs*paso), 'uint32');
            end           
            signal.signal_t = tstem.*signal.signal_t;
        end
        
        function signal = naturalSample(obj,signal, fs, dc) % ACA SE PRODUCE EL MUESTREO NATURAL
%             t = signal.t;
%             carrierSignal = square(2*pi*fs*t, dc); % Creating the square wave 
%             n = length(carrierSignal); % getting the lenght of carrier wave
%             for i = 1:n
%                 %this loop for projecting the carrier amplitude of -1 & +1 to 0 & +1
%                 if (carrierSignal(i)<=0)
%                     carrierSignal(i) = 0;
%                 else
%                     carrierSignal(i) = 1;
%                 end
%             end
%             signal.signal_t = carrierSignal.*signal.signal_t; % Multiplying the carrier & message signal
            t = signal.t;
            squareTrain = (square(2*pi*fs.*t, dc)+1)/2;
            signal.signal_t = signal.signal_t.*squareTrain;
        end
        
        function signal = instantSample(obj, signal, fs, dc) % ACA SE PRODUCE EL MUESTREO INSTANTANEO
            paso = 1/1e6;
            t = 0:paso:1-paso;
            square = zeros(1, length(t));
            i = 1;
            while i<length(t)*(dc/100)
                square(i) = 1;
                i = i + 1;
            end
             signal = obj.idealSample(signal, fs);
             signal.signal_t = conv(signal.signal_t, square);
        end
    end
end