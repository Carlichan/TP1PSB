classdef SignalStorage % contiene una lista de signalControllers, cada signal controller contiene una señal
    properties
       signalList = []      
    end
    
    methods
        function saveSignal(signal)
        % hacer la funcion de guardado trate de copiarla de mi gui pero no
        % sale
        end
        
        function addSignal(obj, signal_)
            obj.signalList = [obj.signalList signal_];
        end
        
        function deleteSignal(obj, index_)
            obj.signalList(index_) = [];
        end
        
        function signal = loadSignal()
            file = uigetfile('*.mat','elegir archivo','Multiselect','off');
            if(file ~=0)
                x = [];
                load(file);
                if ~isempty(x)
                    signal = x;                    
                end
            end
            file = file(1:end-4);
        end
        
    end
    
end 