classdef SignalStorage % contiene una lista de signalControllers, cada signal controller contiene una señal
    properties
       signalList = []      
    end
    
    methods

        function signal = getSignal(position)
           signal = obj.signalList(position); 
        end
%          USAR LA FUNCION RESAMPLE PARA ESTABLECER LA FS DE LA CARGADA EN
%          100 000 
        function saveSignal(obj, signal)
            [file, path]=uiputfile('*.mat','Guardar señal como' );
            if file ~=0
                newFile = fullfile(path, file);
                save(newFile,'signal');
            else
                msgbox('No se ha guardado nada');
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
%             save(newFile,'signal');
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
                  load(file);
                  x = data.x;
                  fsv = data.fs;
                  t = 0:1/fsv:length(x)/fsv-1/fsv;
                  fs = 1e5;
                  tn = 0:1/fs:length(x)/fs-1/fs;
                  signal.signal_t = interp1(t, x, tn);
                  obj.signalList = [obj.signalList signal];
            else
                signal = [];
            end
            
        end
        
    end
    
end 