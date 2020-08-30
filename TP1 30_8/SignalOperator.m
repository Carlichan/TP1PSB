classdef SignalOperator
    properties
        filterOperator
        digitalOperator
    end
    
    methods
        function obj = SignalOperator()
           obj.filterOperator = FilterOperator;
           obj.digitalOperator = DigitalOperator;
        end
        % LLAMADO A FUNCIONES DE FILTRADO  ------------------------------------
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function signal_t= lowpassFilter(obj, signal, filterType,passband, stopband) % llama al filtro lowpass de filterOperator
            signal_t = obj.filterOperator.lowpassFilter(signal, filterType,passband, stopband);
        end
                        
        function signal_t = highpassFilter(obj, signal, filterType, stopband, passband) % llama al filtro highpass de filterOperator
            signal_t = obj.filterOperator.highpassFilter(signal, filterType, stopband, passband);
        end
                
        function signal_t = notchFilter(obj, signal, filterType, passband1, stopband1, stopband2, passband2) % llama al filtro rechazabanda de filterOperator
            signal_t = obj.filterOperator.notchpassFilter(signal, filterType, passband1, stopband1, stopband2, passband2);
        end
                
        function signal_t = passbandFilter(obj, signal, filterType,stopband1, passband1,passband2, stopband2) % llama al filtro pasabanda de filterOperator
            signal_t = obj.filterOperator.passbandFilter(signal, filterType,stopband1, passband1,passband2, stopband2);
        end
        
        function signal_t = integrateFilter(obj, signal) %llama al filtro integrador de filterOperator
            signal_t = obj.filterOperator.integrateFilter(signal);
        end 
                
        function signal_t = derivateFilter(obj, signal, n) %llama al filtro derivador de filterOperator
            signal_t = obj.filterOperator.derivateFilter(signal, n);
        end 
                               
        function signal_t = averageFilter(obj, signal, n) %llama al filtro promediador de filterOperator
            signal_t = obj.filterOperator.averageFilter(signal, n);
        end 
        
        % LLAMADO A FUNCIONES DE MUESTREO  ------------------------------------
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function signal = idealSample(obj, signal) % llama a la funcion que hará el muestreo ideal en DigitalOperator
            signal = obj.digitalOperator.idealSample(signal); 
        end
        
        function signal = naturalSample(obj, signal, dc) % llama a la funcion que hará el muestreo natural en DigitalOperator
            signal = obj.digitalOperator.naturalSample(signal, dc); 
        end
        
        function signal = instantSample(obj, signal, dc) % llama a la funcion que hará el muestreo instantaneo en DigitalOperator
            signal = obj.digitalOperator.instantSample(signal, dc); 
        end
              
        
        % FUNCIONES DE OPERACIÓN  ------------------------------------
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function signal = sum(signal1,signal2)
            %          VER QUE PASA SI VIVEN EN T DIFERENTES, O  TIENEN DISTINTO LENGTH
           signal = signal1+signal2;
        end
        function signal = multiplicate(signal1,signal2)
            %          VER QUE PASA SI VIVEN EN T DIFERENTES, O  TIENEN DISTINTO LENGTH
           signal = signal1.*signal2;
        end
        function signal = substract(signal1,signal2)
            %          VER QUE PASA SI VIVEN EN T DIFERENTES, O  TIENEN DISTINTO LENGTH
            signal = signal1-signal2;
        end
        function signal = dephase(signal, amount)
            %          desplazamiento horizontal
            
        end
        function signal = offset(signal, amount)
            %          desplazamiento vertical
        end
    end
    
end 
