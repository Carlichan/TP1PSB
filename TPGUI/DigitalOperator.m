classdef DigitalOperator
    properties
        
    end
    methods
        
        function signal = idealSample(obj, signal, fs) % ACA SE PRODUCE EL MUESTREO IDEAL                        
            paso = 1/1e5;              
            tstem = zeros(1,length(signal.signal_t));
            i = 1;
            while i<length(signal.signal_t)
                tstem(i) = 1;
                i = i+ cast(1/(fs*paso), 'uint32');
            end           
            signal.signal_t = tstem.*signal.signal_t;
        end
        
        function signal = naturalSample(obj,signal, fs, dc) % ACA SE PRODUCE EL MUESTREO NATURAL
            t = signal.t;
            carrierSignal = square(2*pi*fs*t, dc); % Creating the square wave 
            n = length(carrierSignal); % getting the lenght of carrier wave
            for i = 1:n
                %this loop for projecting the carrier amplitude of -1 & +1 to 0 & +1
                if (carrierSignal(i)<=0)
                    carrierSignal(i) = 0;
                else
                    carrierSignal(i) = 1;
                end
            end
            signal.signal_t = carrierSignal.*signal.signal_t; % Multiplying the carrier & message signal
%             t = signal.t;
%             squareTrain = (square(2*pi*fs.*t, dc)+1)/2;
%             signal.signal_t = signal.signal_t.*squareTrain;
        end
        
        function signal = instantSample(obj, signal, fs, dc) % ACA SE PRODUCE EL MUESTREO INSTANTANEO
            paso = 1/1e5;
            i = 1;
            len = length(signal.signal_t);
            mask = zeros(1,length(signal.signal_t));
            ts_vector = 1/(fs*paso);
            ts_hold_vector = cast(ts_vector*(dc/100), 'uint32');
            while i<=len
                j = 0;
                temp = signal.signal_t(i);
                while (j<ts_hold_vector) && (j+i<=len)
                    signal.signal_t(i+j) = temp;
                    mask(i+j) = 1;
                    j = j+1; 
                end
                i = i+ cast(ts_vector, 'uint32');
            end
            signal.signal_t = mask.*signal.signal_t;           
        end
        
        function signal = DAC(obj, signal, fs)
            % la fs debe ser igual a la que tiene la idealSample
            paso = 1/1e5;
            len = length(signal.signal_t);
            i = 1;
            ts_vector = 1/(fs*paso);
            while i<=len
                j = 0;
                temp = signal.signal_t(i);
                while (j<ts_vector) && (j+i<=len)
                    signal.signal_t(i+j) = temp;
                    j = j+1;
                end
                 i = i+ cast(ts_vector, 'uint32');
            end
        end
        
        function signal = ADC(obj, signal, fs)
            paso = 1/1e5;
            tstem = zeros(1,length(signal.signal_t));
            i = 1;
            while i<length(signal.signal_t)
                tstem(i) = 1;
                i = i+ cast(1/(fs*paso), 'uint32');
            end           
            signal.signal_t = tstem.*signal.signal_t;
        end
        % MOVER ESTA FUNCION A SIGNAL OPERATOR
        function listen2signal(obj, signal)
            soundsc(signal.signal_t);
        end
        %%%
    end
end