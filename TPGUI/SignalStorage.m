classdef SignalStorage % contiene una lista de signalControllers, cada signal controller contiene una señal
    properties
       signalList = []      
    end
    
    methods

        function signal = getSignal(position)
           signal = obj.signalList(position); 
        end
        
        function saveSignal(obj, signal, tmin, tmax, fs)
            [file, path]=uiputfile('*.mat','Guardar señal como' );
            if file ~=0
                newFile = fullfile(path, file);
            end
%             tcounter = 0;
%             i = 1;
%             paso = 1/1e6;
%             while tcounter<tmin 
%                 signal.signal_t(i) = 0;
% %                 i = i+1/(fs*paso);
%                   i=i+1;
%                 tcounter = tcounter+ 1/fs;
%             end
%             while tcounter>tmax && tcounter< length(signal.signal_t)
%                 signal.signal_t(i) = 0;
% %                 i = i+1/(fs*paso);
%                 i = i+1;
%                 tcounter = tcounter+1/fs;
%             end
            save(newFile,'signal');
        end
        
        function addSignal(obj, signal_)
            obj.signalList = [obj.signalList signal_];
        end
        
        function deleteSignal(obj, index_)
            obj.signalList(index_) = [];
        end
        
        function signal = loadSignal(obj)
            file = uigetfile('*.mat','elegir archivo','Multiselect','off');
            if(file ~=0)
                  signal = load(file);
                  signal = signal.signal;
            end
            obj.signalList = [obj.signalList signal];
        end
        
    end
    
end 