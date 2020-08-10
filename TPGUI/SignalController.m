classdef SignalController % contiene una señal 
    properties
        t
        f
        signal_t
        signal_f
    end
    
    methods
        function obj = SignalController(t_,f_,signal_t_,signal_f_)
            obj.t = t_;
            obj.f = f_;
            obj.signal_t= signal_t_;
            obj.signal_f = signal_f_;
        end
        
        function [t_, f_, signal_t_, signal_f_] = getSignal(self)
            t_ = self.t;
            f_ = self.f;
            signal_t_ = self.signal_t;
            signal_f_ = self.signal_f;
        end
    
        function setSignal(self, t_, f_, signal_t_, signal_f_)
            self.t = t_;
            self.f = f_;
            self.signal_t= signal_t_;
            self.signal_f = signal_f_;
        end 

    end
end

