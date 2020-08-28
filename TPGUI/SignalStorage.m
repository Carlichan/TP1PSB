classdef SignalStorage % contiene una lista de signalControllers, cada signal controller contiene una se�al
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
            [file, path]=uiputfile('*.mat','Guardar se�al como' );
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
                  load(file);
                  t1 = signal.t;
                  deltat = t1(2)-t1(1);
%                   signalsfs = 1/deltat;
                  fs = 1e5;
                  tmin = signal.t(1);
                  tmax = (length(signal.t)*deltat)+tmin;
                  signal.t = tmin:1/fs:tmax-1/fs;
                  signal.signal_t = interp1(t1, signal.signal_t, signal.t);
                  obj.signalList = [obj.signalList signal];
            else
                msgbox('No se ha seleccionado nada');
                signal = [];
            end
            
        end
        
    end
    
end 