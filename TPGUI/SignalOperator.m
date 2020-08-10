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

        function signal = lowpassFilter(obj, signal, filterType) % llama al filtro lowpass de filterOperator
            signal = obj.filterOperator.lowpassFilter(signal, filterType);
        end
                        
        function signal = highpassFilter(obj, signal, filterType) % llama al filtro highpass de filterOperator
            signal = obj.filterOperator.highpassFilter(signal, filterType);
        end
                
        function signal = notchFilter(obj, signal, filterType) % llama al filtro rechazabanda de filterOperator
            signal = obj.filterOperator.notchpassFilter(signal, filterType);
        end
                
        function signal = passbandFilter(obj, signal, filterType) % llama al filtro pasabanda de filterOperator
            signal = obj.filterOperator.passbandFilter(signal, filterType);
        end
        
        function signal = integrateFilter(obj, signal) %llama al filtro integrador de filterOperator
            signal = obj.filterOperator.integrateFilter(signal);
        end 
                
        function signal = derivateFilter(obj, signal, n) %llama al filtro derivador de filterOperator
            signal = obj.filterOperator.derivateFilter(signal, n);
        end 
                               
        function signal = averageFilter(obj, signal, n) %llama al filtro promediador de filterOperator
            signal = obj.filterOperator.averageFilter(signal, n);
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
