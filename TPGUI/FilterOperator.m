classdef FilterOperator
    properties
        
    end
    methods
               
         function signal = lowpassFilter(signal, filterType, passband, stopband) % filterType puede ser 'FIR' o 'IIR'
            % ACA HACER EL FILTRO PASABAJOS (FIR E IIR) 
            Fs = 100000;
            if(strcmp(filterType, 'IIR'))
                %Pasabajos IIR
                Apass = 1;                  % Passband Ripple (dB)
                Astop = 80;                 % Stopband Attenuation (dB)
                match = 'stopband';         % Band to match exactly
                h  = fdesign.lowpass(passband, stopband, Apass, Astop, Fs);
                Hd = design(h, 'butter', 'MatchExactly', match);
                signal.signal_t = filter(Hd, signal.signal_t);
            else
                %Pasabajos FIR
                Dpass = 0.057501127785;     % Passband Ripple
                Dstop = 0.0001;         % Stopband Attenuation
                flag  = 'scale';         % Sampling Flag
                [N,Wn,BETA,TYPE] = kaiserord([passband stopband]/(Fs/2), [1 0], [Dstop Dpass]);
                b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
                Hd = dfilt.dffir(b);
                filtro = Hd.Numerator;
                signal.signal_t = conv(signal.signal_t, filtro,'same');
            end
        end
                
        function signal = highpassFilter(signal, filterType, stopband, passband) % filterType puede ser 'FIR' o 'IIR'
            % ACA HACER EL FILTRO PASAALTOS (FIR E IIR)
            Fs = 100000;
            if(strcmp(filterType, 'IIR'))
                Astop = 80;          % Stopband Attenuation (dB)
                Apass = 1;           % Passband Ripple (dB)
                match = 'stopband';  % Band to match exactly
                h  = fdesign.highpass(stopband, passband, Astop, Apass, Fs);
                Hd = design(h, 'butter', 'MatchExactly', match);
                signal.signal_t = filter(Hd, signal.signal_t);
            else
                Dstop = 0.0001;          % Stopband Attenuation
                Dpass = 0.057501127785;  % Passband Ripple
                flag  = 'scale';         % Sampling Flag
                [N,Wn,BETA,TYPE] = kaiserord([stopband passband]/(Fs/2), [0 1], [Dpass Dstop]);
                b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
                Hd = dfilt.dffir(b);
                filtro = Hd.Numerator;
                signal.signal_t = conv(signal.signal_t, filtro,'same');
            end
        end
                
        function signal = notchFilter(signal, filterType, passband1, stopband1, stopband2, passband2) % filterType puede ser 'FIR' o 'IIR'
            % ACA HACER EL FILTRO RECHAZABANDA (FIR E IIR)
            Fs = 100000;
            if(strcmp(filterType, 'IIR'))
                Apass1 = 0.5;         % First Passband Ripple (dB)
                Astop  = 60;          % Stopband Attenuation (dB)
                Apass2 = 1;           % Second Passband Ripple (dB)
                match  = 'stopband';  % Band to match exactly
                h  = fdesign.bandstop(passband1, stopband1, stopband2, passband2, Apass1, Astop, ...
                      Apass2, Fs);
                Hd = design(h, 'butter', 'MatchExactly', match);
                signal.signal_t = filter(Hd, signal.signal_t);
            else  
                Dpass1 = 0.028774368332;  % First Passband Ripple
                Dstop  = 0.001;           % Stopband Attenuation
                Dpass2 = 0.057501127785;  % Second Passband Ripple
                flag   = 'scale';         % Sampling Flag
                [N,Wn,BETA,TYPE] = kaiserord([passband1 stopband1 stopband2 passband2]/(Fs/2), [1 ...
                             0 1], [Dpass1 Dstop Dpass2]);
                b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
                Hd = dfilt.dffir(b);
                filtro = Hd.Numerator;
                signal.signal_t = conv(signal.signal_t, filtro,'same');
            end
        end
                
        function signal = passbandFilter(signal, filterType,stopband1, passband1,passband2, stopband2) % filterType puede ser 'FIR' o 'IIR'
           % ACA HACER EL FILTRO PASABANDA (FIR E IIR)
           Fs = 100000;
           if(strcmp(filterType, 'IIR'))
               Astop1 = 60;            % First Stopband Attenuation (dB)
               Apass  = 1;           % Passband Ripple (dB)
               Astop2 = 80;          % Second Stopband Attenuation (dB)
               match  = 'stopband';  % Band to match exactly
               h  = fdesign.bandpass(stopband1, passband1, passband2, stopband2, Astop1, Apass, ...
                      Astop2, Fs);
               Hd = design(h, 'butter', 'MatchExactly', match);
               signal.signal_t = filter(Hd, signal.signal_t);
           else
               Dstop1 = 0.001;           % First Stopband Attenuation
               Dpass  = 0.057501127785;  % Passband Ripple
               Dstop2 = 0.0001;          % Second Stopband Attenuation
               flag   = 'scale';         % Sampling Flag
               [N,Wn,BETA,TYPE] = kaiserord([stopband1 passband1 passband2 stopband2]/(Fs/2), [0 ...
                             1 0], [Dstop1 Dpass Dstop2]);
               b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
               Hd = dfilt.dffir(b);
               filtro = Hd.Numerator;
               signal.signal_t = conv(signal.signal_t, filtro,'same');
           end
        end
        
        function signal = integrateFilter(signal) % aca se produce el filtrado del tipo integrador
           % ACA HACER EL FILTRO INTEGRADOR
           Fs = 100000;
           Ts = 1/Fs;
           b = (Ts/2) * [1 1];
           a = [1 -1];
           signal.signal_t  = filter(b, a, signal.signal_t );
        end 
                
        function signal = derivateFilter(signal, n) %aca se produce el filtrado del tipo DERIVADOR
           % ACA HACER EL FILTRO DERIVADOR
           Fs = 100000;
           Ts = 1/Fs;
           %n es el skip factor
           filtro = [1 zeros(1,2*n - 1) -1] / (2*n*Ts);
           signal.signal_t = conv(signal.signal_t, filtro,'same');
        end 
                               
        function signal = averageFilter(signal, n) %aca se produce el filtrado del tipo PROMEDIADOR
            % ACA HACER EL FILTRO PROMEDIADOR
            L = length(x);
            filtro = [zeros(1,L-n) ones(1,n)]/L;
            signal.signal_t = conv(signal.signal_t, filtro, 'same');
        end 
        
    end
end
