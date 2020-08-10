classdef FilterOperator
    properties
        
    end
    methods
               
        function signal = lowpassFilter(signal, filterType) % filterType puede ser 'FIR' o 'IIR'
            % ACA HACER EL FILTRO PASABAJOS (FIR E IIR)
        end
                
        function signal = highpassFilter(signal, filterType) % filterType puede ser 'FIR' o 'IIR'
            % ACA HACER EL FILTRO PASAALTOS (FIR E IIR)
        end
                
        function signal = notchFilter(signal, filterType) % filterType puede ser 'FIR' o 'IIR'
            % ACA HACER EL FILTRO RECHAZABANDA (FIR E IIR)
        end
                
        function signal = passbandFilter(signal, filterType) % filterType puede ser 'FIR' o 'IIR'
           % ACA HACER EL FILTRO PASABANDA (FIR E IIR)
        end
        
        function signal = integrateFilter(signal) % aca se produce el filtrado del tipo integrador
           % ACA HACER EL FILTRO INTEGRADOR
        end 
                
        function signal = derivateFilter(signal, n) %aca se produce el filtrado del tipo DERIVADOR
           % ACA HACER EL FILTRO DERIVADOR
        end 
                               
        function signal = averageFilter(signal, n) %aca se produce el filtrado del tipo PROMEDIADOR
            % ACA HACER EL FILTRO PROMEDIADOR
        end 
        
    end
end
