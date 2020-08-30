function varargout = TP1GUI(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TP1GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TP1GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TP1GUI is made visible.
function TP1GUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
evalin('base', 'clearvars');
clc
global senales;
senales = {};
global cantSenales;
cantSenales = 0;
% global dft;
% dft = {};

% --- Outputs from this function are returned to the command line.
function varargout = TP1GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listaSenales.
function listaSenales_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function listaSenales_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over idealrb.
function idealrb_ButtonDownFcn(hObject, eventdata, handles)



function samplefs_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function samplefs_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sampleButton.
function sampleButton_Callback(hObject, eventdata, handles)
digitalOperator = DigitalOperator();
ideal = get(handles.idealrb,'Value');
natural = get(handles.naturalrb,'Value');
instant = get(handles.instantrb,'Value');
fs = str2double(get(handles.samplefs, 'String'));
dc = str2double(get(handles.sampledc, 'String'));
if ideal == 1
    digitalOperator.idealSample(signal);
elseif natural == 1
    digitalOperator.naturalSample(signal,fs,dc);
elseif instant == 1
    digitalOperator.instantSample(signal,fs,dc);
end



function sampledc_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function sampledc_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frec_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function frec_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in create.
function create_Callback(hObject, eventdata, handles)
global senales
global cantSenales
global dft
fs = 100000;
Ts = 1/fs;
sin = get(handles.sin,'Value');
square = get(handles.square,'Value');
triangle = get(handles.triangle,'Value');
GaussianNoise = get(handles.gaussianNoise,'Value');
UniformNoise = get(handles.UniformNoise,'Value');
dc = str2double(get(handles.dc, 'String'));
frequency = str2double(get(handles.frec, 'String'));
phase = str2double(get(handles.phase, 'String'));
amplitude = str2double(get(handles.amplitude, 'String'));
mean = str2double(get(handles.ValorMedia, 'String'));
StandardDev = str2double(get(handles.ValorDesvio, 'String'));
tmin =  str2double(get(handles.tmin, 'String'));
tmax =  str2double(get(handles.tmax, 'String'));
signalGenerator = SignalGenerator(fs, tmin, tmax);
cantSenales = cantSenales +1;
if sin == 1
    signal_t = signalGenerator.generateSinusoidal(frequency,amplitude,phase);
    nuevaSenal = ['Se�al ' num2str(cantSenales) ' (seno de ' num2str(frequency) 'Hz)'];
elseif square == 1
    signal_t = signalGenerator.generateSquare(frequency,amplitude,dc);
    nuevaSenal = ['Se�al ' num2str(cantSenales) ' (se�al cuadrada)'];
elseif triangle == 1
    signal_t= signalGenerator.generateTriangular(amplitude,frequency,dc);
     nuevaSenal = ['Se�al ' num2str(cantSenales) ' (se�al triangular)'];
elseif GaussianNoise == 1
    signal_t = signalGenerator.generatePoissonNoise(mean ,StandardDev);
     nuevaSenal = ['Se�al ' num2str(cantSenales) ' (ruido Gaussiano)'];
elseif UniformNoise == 1
    signal_t = signalGenerator.generateUniformNoise(amplitude);
     nuevaSenal = ['Se�al ' num2str(cantSenales) ' (ruido uniforme)'];
end
senales{cantSenales} = signal_t;
% dft{cantSenales} = signal_f;
listaSenales = get(handles.listaSenales, 'String');
if(cantSenales == 1)
    set(handles.listaSenales, 'String', nuevaSenal);
    set(handles.panelMuestreo, 'Visible', 'On');
    set(handles.panelLimTiempo, 'Visible', 'On');
    set(handles.panelLimFrec, 'Visible', 'On');
    set(handles.panelFiltro, 'Visible', 'On');
    set(handles.panelOperaciones, 'Visible', 'On');
    set(handles.aagraficar, 'Visible', 'On');
    set(handles.delete, 'Visible', 'On');
    set(handles.listen, 'Visible', 'On');
    set(handles.save, 'Visible', 'On');
else
    listaSenales = char(listaSenales, nuevaSenal);
    set(handles.listaSenales, 'String', listaSenales);
end

function dc_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function dc_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tmin_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function tmin_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tmax_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function tmax_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amplitude_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitude as text
%        str2double(get(hObject,'String')) returns contents of amplitude as a double


% --- Executes during object creation, after setting all properties.
function amplitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phase_Callback(hObject, eventdata, handles)
% hObject    handle to phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phase as text
%        str2double(get(hObject,'String')) returns contents of phase as a double


% --- Executes during object creation, after setting all properties.
function phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
global senales
global cantSenales
% global dft
signalStorage = SignalStorage();
signal = signalStorage.loadSignal();
if(~isempty(signal))
    signal_t = signal.signal_t;
%     signal_f = abs(fftshift(fft(signal_t)));
    cantSenales = cantSenales + 1;
    senales{cantSenales} = signal_t;
%     dft{cantSenales} = signal_f;
    listaSenales = get(handles.listaSenales, 'String');
    nuevaSenal = ['Se�al ' num2str(cantSenales) ];
    if(cantSenales == 1)
        set(handles.listaSenales, 'String', nuevaSenal);
    else
        listaSenales = char(listaSenales, nuevaSenal);
        set(handles.listaSenales, 'String', listaSenales);
    end
else
    msgbox('No se ha seleccionado ninguna se�al');
end

% --- Executes on button press in listen.
function listen_Callback(hObject, eventdata, handles)
% hObject    handle to listen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in highpass.
function highpass_Callback(hObject, eventdata, handles)
set(handles.filter, 'Visible', 'On');
set(handles.filter, 'String', 'Filtrar(HP)');
set(handles.typeFilter, 'Visible', 'On');
set(handles.text1, 'Visible', 'On');
set(handles.text1, 'String', 'fstop');
set(handles.text2, 'Visible', 'On');
set(handles.text2, 'String', 'fpass');
set(handles.text3, 'Visible', 'Off');
set(handles.text4, 'Visible', 'Off');
set(handles.valText1, 'Visible', 'On');
set(handles.valText2, 'Visible', 'On');
set(handles.valText3, 'Visible', 'Off');
set(handles.valText4, 'Visible', 'Off');


% --- Executes on button press in lowpass.
function lowpass_Callback(hObject, eventdata, handles)
set(handles.filter, 'Visible', 'On');
set(handles.filter, 'String', 'Filtrar(LP)');
set(handles.typeFilter, 'Visible', 'On');
set(handles.text1, 'Visible', 'On');
set(handles.text1, 'String', 'fpass');
set(handles.text2, 'Visible', 'On');
set(handles.text2, 'String', 'fstop');
set(handles.text3, 'Visible', 'Off');
set(handles.text4, 'Visible', 'Off');
set(handles.valText1, 'Visible', 'On');
set(handles.valText2, 'Visible', 'On');
set(handles.valText3, 'Visible', 'Off');
set(handles.valText4, 'Visible', 'Off');


% --- Executes on button press in passband.
function passband_Callback(hObject, eventdata, handles)
set(handles.filter, 'Visible', 'On');
set(handles.filter, 'String', 'Filtrar(PB)');
set(handles.typeFilter, 'Visible', 'On');
set(handles.text1, 'Visible', 'On');
set(handles.text1, 'String', 'fstop1');
set(handles.text2, 'Visible', 'On');
set(handles.text2, 'String', 'fpass1');
set(handles.text3, 'Visible', 'On');
set(handles.text3, 'String', 'fpass2');
set(handles.text4, 'Visible', 'On');
set(handles.text4, 'String', 'fstop2');
set(handles.valText1, 'Visible', 'On');
set(handles.valText2, 'Visible', 'On');
set(handles.valText3, 'Visible', 'On');
set(handles.valText4, 'Visible', 'On');


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in derivator.
function derivator_Callback(hObject, eventdata, handles)
set(handles.filter, 'Visible', 'On');
set(handles.filter, 'String', 'Filtrar(Deriv)');
set(handles.typeFilter, 'Visible', 'Off');
set(handles.text1, 'Visible', 'Off');
set(handles.text2, 'Visible', 'Off');
set(handles.text3, 'Visible', 'Off');
set(handles.text4, 'Visible', 'On');
set(handles.text4, 'String', 'N�mero de muestras');
set(handles.valText1, 'Visible', 'Off');
set(handles.valText2, 'Visible', 'Off');
set(handles.valText3, 'Visible', 'Off');
set(handles.valText4, 'Visible', 'On');




function tlimmin_Callback(hObject, eventdata, handles)
tmin =  str2double(get(handles.tlimmin, 'String'));
tmax =  str2double(get(handles.tlimmax, 'String'));
aagraficar_Callback(hObject, eventdata, handles);
% if((~isnan(tmin))&&(~isnan(tmax)))
%     if(tmin<tmax)
%         aagraficar_Callback(hObject, eventdata, handles);
%     else
%         msgbox('Recordar que tmin<tmax');
%     end
% else
%     msgbox('Poner valores correctos');
% end



% --- Executes during object creation, after setting all properties.
function tlimmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tlimmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tlimmax_Callback(hObject, eventdata, handles)
tmin =  str2double(get(handles.tlimmin, 'String'));
tmax =  str2double(get(handles.tlimmax, 'String'));
aagraficar_Callback(hObject, eventdata, handles);
% if((~isnan(tmin))&&(~isnan(tmax)))
%     if(tmin<tmax)
%         aagraficar_Callback(hObject, eventdata, handles);
%     else
%         msgbox('Recordar que tmin<tmax');
%     end
% else
%     msgbox('Poner valores correctos');
% end


% --- Executes during object creation, after setting all properties.
function tlimmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tlimmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function flimmin_Callback(hObject, eventdata, handles)
fmin =  str2double(get(handles.flimmin, 'String'));
fmax =  str2double(get(handles.flimmax, 'String'));
if((~isnan(fmin))&&(~isnan(fmax)))
    if(fmin<fmax)
        aagraficar_Callback(hObject, eventdata, handles);
    else
        msgbox('Recordar que fmin<fmax');
    end
else
    msgbox('Poner valores correctos');
end



% --- Executes during object creation, after setting all properties.
function flimmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flimmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function flimmax_Callback(hObject, eventdata, handles)
fmin =  str2double(get(handles.flimmin, 'String'));
fmax =  str2double(get(handles.flimmax, 'String'));
if((~isnan(fmin))&&(~isnan(fmax)))
    if(fmin<fmax)
        aagraficar_Callback(hObject, eventdata, handles);
    else
        msgbox('Recordar que fmin<fmax');
    end
else
    msgbox('Poner valores correctos');
end


% --- Executes during object creation, after setting all properties.
function flimmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flimmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ValorMedia_Callback(hObject, eventdata, handles)
% hObject    handle to ValorMedia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValorMedia as text
%        str2double(get(hObject,'String')) returns contents of ValorMedia as a double


% --- Executes during object creation, after setting all properties.
function ValorMedia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValorMedia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ValorDesvio_Callback(hObject, eventdata, handles)
% hObject    handle to ValorDesvio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ValorDesvio as text
%        str2double(get(hObject,'String')) returns contents of ValorDesvio as a double


% --- Executes during object creation, after setting all properties.
function ValorDesvio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ValorDesvio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to tmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tmin as text
%        str2double(get(hObject,'String')) returns contents of tmin as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tmax as text
%        str2double(get(hObject,'String')) returns contents of tmax as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in integer.
function integer_Callback(hObject, eventdata, handles)
set(handles.filter, 'Visible', 'Off');
set(handles.typeFilter, 'Visible', 'Off');
set(handles.text1, 'Visible', 'Off');
set(handles.text2, 'Visible', 'Off');
set(handles.text3, 'Visible', 'Off');
set(handles.text4, 'Visible', 'Off');
set(handles.valText1, 'Visible', 'Off');
set(handles.valText2, 'Visible', 'Off');
set(handles.valText3, 'Visible', 'Off');
set(handles.valText4, 'Visible', 'Off');
global senales
global cantSenales
signalOperator = SignalOperator();
nroSenal = get(handles.listaSenales, 'Value');
if(length(nroSenal) == 1)
    signal_t = senales{nroSenal};
    nuevaSenal  = signalOperator.integrateFilter(signal_t);
    cantSenales = cantSenales + 1;
    nombre = ['Se�al' num2str(cantSenales) '(se�al ' num2str(nroSenal-1) ' filtrada)' ]
    senales{cantSenales} = nuevaSenal;
    listaSenales = get(handles.listaSenales, 'String');
    listaSenales = char(listaSenales, nombre);
    set(handles.listaSenales, 'String', listaSenales);
else
    msgbox('Se filtra una se�al a la vez, seleccionar solamente una');
end


% --- Executes on button press in average.
function average_Callback(hObject, eventdata, handles)
set(handles.filter, 'Visible', 'On');
set(handles.filter, 'String', 'Filtrar(prom)');
set(handles.typeFilter, 'Visible', 'Off');
set(handles.text1, 'Visible', 'Off');
set(handles.text2, 'Visible', 'Off');
set(handles.text3, 'Visible', 'Off');
set(handles.text4, 'Visible', 'On');
set(handles.text4, 'String', 'N�mero de muestras');
set(handles.valText1, 'Visible', 'Off');
set(handles.valText2, 'Visible', 'Off');
set(handles.valText3, 'Visible', 'Off');
set(handles.valText4, 'Visible', 'On');


% --- Executes on button press in notchband.
function notchband_Callback(hObject, eventdata, handles)
set(handles.filter, 'Visible', 'On');
set(handles.filter, 'String', 'Filtrar(NB)');
set(handles.typeFilter, 'Visible', 'On');
set(handles.text1, 'Visible', 'On');
set(handles.text1, 'String', 'fpass1');
set(handles.text2, 'Visible', 'On');
set(handles.text2, 'String', 'fstop1');
set(handles.text3, 'Visible', 'On');
set(handles.text3, 'String', 'fstop2');
set(handles.text4, 'Visible', 'On');
set(handles.text4, 'String', 'fpass2');
set(handles.valText1, 'Visible', 'On');
set(handles.valText2, 'Visible', 'On');
set(handles.valText3, 'Visible', 'On');
set(handles.valText4, 'Visible', 'On');



% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
global senales
global cantSenales
global dft

nroSenal = get(handles.listaSenales, 'Value');
listaSenales = get(handles.listaSenales, 'String');
x = get(handles.listaSenales, 'Value');
signalStorage = SignalStorage();
%for i = x
    nroSenal = x;
    listaSenales(nroSenal, :) = [];
    cantSenales = cantSenales -1;
    if( cantSenales == 0)
        %Borrar el �nico elemento
        senales{1} = [];
%         dft{1} = [];
        set(handles.listaSenales, 'Value', 1);
        set(handles.panelFiltro, 'Visible', 'Off');
        set(handles.save, 'Visible', 'Off');
        set(handles.delete, 'Visible', 'Off');
        set(handles.listen, 'Visible', 'Off');
    else
        %m�s elementos
        senales{nroSenal} = [];
%         dft{nroSenal} = [];
        nroSenal = nroSenal - 1;
        if(nroSenal == 0)
            nroSenal = 1;
        end
        set(handles.listaSenales, 'Value', nroSenal);
    end
     set(handles.listaSenales, 'String', listaSenales);
 %end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitude as text
%        str2double(get(hObject,'String')) returns contents of amplitude as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sin.
function sin_Callback(hObject, eventdata, handles)
% hObject    handle to sin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
% Hint: get(hObject,'Value') returns toggle state of sin


% --- Executes on button press in aagraficar.
function aagraficar_Callback(hObject, eventdata, handles)
global senales
% global dft
fs = 100000;
Ts = 1/fs;
tmin =  str2double(get(handles.tlimmin, 'String'));
tmax =  str2double(get(handles.tlimmax, 'String'));
xmin =  str2double(get(handles.xlimmin, 'String'));
xmax =  str2double(get(handles.xlimmax, 'String'));
fmin =  str2double(get(handles.flimmin, 'String'));
fmax =  str2double(get(handles.flimmax, 'String'));
Xfmin =  str2double(get(handles.Xflimmin, 'String'));
Xfmax =  str2double(get(handles.Xflimmax, 'String'));
if(~isempty(senales))
    x = get(handles.listaSenales, 'Value');
    for nroSenal = x
        senal = senales{nroSenal};
        t = 0:1/fs:length(senal)/fs-1/fs;
        n =  length(senal)
        Fs = length(t);
        plot(handles.axes1, t, senal);
        grid(handles.axes1, 'on');
        hold(handles.axes1, 'on');
        title(handles.axes1,['Se�al: ' num2str(nroSenal) ' en tiempo']);
        xlabel(handles.axes1,'Tiempo [s]');
        ylabel(handles.axes1,'Voltios [V]');
        if((~isempty(tmin))&&(~isempty(tmax)))
            if(tmin<tmax)
                xlim(handles.axes1,[tmin tmax]);
            else
                msgbox('Poner valores correctos');
            end
        end
        if((~isempty(xmin))&&(~isempty(xmax)))
            if(xmin<xmax)
                ylim(handles.axes1,[xmin xmax]);
            else
                msgbox('Poner valores correctos');
            end
        end
        %dft
        f = Fs*(-n/2:n/2-1)/n;
%         dftSenal = dft{nroSenal};
        dftSenal = abs(fftshift(fft(senal)));
        plot(handles.axes2,f,dftSenal);
        hold(handles.axes2, 'on');
        title('Espectro de la se�al');
        ylabel('Amplitud');
        xlabel('Frecuencia [Hz]');
        grid on;
        if((~isempty(fmin))&&(~isempty(fmax)))
            if(fmin<fmax)
                xlim(handles.axes2,[fmin fmax]);
            else
                msgbox('Poner valores correctos');
            end
        end
        if((~isempty(Xfmin))&&(~isempty(Xfmax)))
            if(Xfmin<Xfmax)
                ylim(handles.axes2,[Xfmin Xfmax]);
            else
                msgbox('Poner valores correctos');
            end
        end
    end
    hold(handles.axes1, 'off');
    hold(handles.axes2, 'off');
end



function Xflimmin_Callback(hObject, eventdata, handles)
Xfmin =  str2double(get(handles.Xflimmin, 'String'));
Xfmax =  str2double(get(handles.Xflimmax, 'String'));
if((~isnan(Xfmin))&&(~isnan(Xfmax)))
    if(Xfmin<Xfmax)
        aagraficar_Callback(hObject, eventdata, handles);
    else
        msgbox('Recordar que X(f)min<X(f)max');
    end
else
    msgbox('Poner valores correctos');
end


% --- Executes during object creation, after setting all properties.
function Xflimmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xflimmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xflimmax_Callback(hObject, eventdata, handles)
Xfmin =  str2double(get(handles.Xflimmin, 'String'));
Xfmax =  str2double(get(handles.Xflimmax, 'String'));
if((~isnan(Xfmin))&&(~isnan(Xfmax)))
    if(Xfmin<Xfmax)
        aagraficar_Callback(hObject, eventdata, handles);
    else
        msgbox('Recordar que X(f)min<X(f)max');
    end
else
    msgbox('Poner valores correctos');
end



% --- Executes during object creation, after setting all properties.
function Xflimmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xflimmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xlimmin_Callback(hObject, eventdata, handles)
xmin =  str2double(get(handles.xlimmin, 'String'));
xmax =  str2double(get(handles.xlimmax, 'String'));
if((~isnan(xmin))&&(~isnan(xmax)))
    if(xmin<xmax)
        aagraficar_Callback(hObject, eventdata, handles);
    else
        msgbox('Recordar que xmin<xmax');
    end
else
    msgbox('Poner valores correctos');
end

% --- Executes during object creation, after setting all properties.
function xlimmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlimmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xlimmax_Callback(hObject, eventdata, handles)
xmin =  str2double(get(handles.xlimmin, 'String'));
xmax =  str2double(get(handles.xlimmax, 'String'));
if((~isnan(xmin))&&(~isnan(xmax)))
    if(xmin<xmax)
        aagraficar_Callback(hObject, eventdata, handles);
    else
        msgbox('Recordar que xmin<xmax');
    end
else
    msgbox('Poner valores correctos');
end



% --- Executes during object creation, after setting all properties.
function xlimmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlimmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(~, eventdata, handles)
global senales
x = get(handles.listaSenales, 'Value');
if (length(x)== 1)
    x = get(handles.listaSenales, 'Value');
    nroSenal = x;
    senal = senales{nroSenal};
    signalStorage = SignalStorage();
    signalStorage.saveSignal(senal);
else
    msgbox('Se guarda una se�al a la vez, seleccionar de a una');
end
    


% --- Executes on button press in filter.
function filter_Callback(hObject, eventdata, handles)
global senales
global cantSenales
filter = get(handles.filter, 'String');
signalOperator = SignalOperator();
nroSenal = get(handles.listaSenales, 'Value');
if(length(nroSenal) == 1)
    senal = senales{nroSenal};
    if(strcmp(filter,'Filtrar(HP)'))
        contents = cellstr(get(handles.typeFilter, 'String'));
        typeFilter =contents(get(handles.typeFilter, 'Value'));
        fstop =  str2double(get(handles.valText1, 'String'));
        fpass =  str2double(get(handles.valText2, 'String'));
        if((~isnan(fstop))&&(~isnan(fpass))&&(fstop<fpass))
            if(strcmp(typeFilter,'FIR'))
                senalFiltrada  = signalOperator.highpassFilter(senal,typeFilter,fstop,fpass);
            else
                senalFiltrada  = signalOperator.highpassFilter(senal,typeFilter,fstop,fpass);
            end
            listaSenales = get(handles.listaSenales, 'String');
            cantSenales = cantSenales + 1;
            senales{cantSenales} = senalFiltrada;
            nuevaSenal = ['Se�al ' num2str(cantSenales) '(se�al ' num2str(nroSenal) ' filtrada)' ];
            listaSenales = char(listaSenales, nuevaSenal);
            set(handles.listaSenales, 'String', listaSenales);
        else
            msgbox('Poner valores correctos, recordar que que fstop<fpass');
        end
    elseif(strcmp(filter,'Filtrar(LP)'))
        contents = cellstr(get(handles.typeFilter, 'String'));
        typeFilter =contents(get(handles.typeFilter, 'Value'));
        fpass =  str2double(get(handles.valText1, 'String'));
        fstop =  str2double(get(handles.valText2, 'String'));
        if((~isnan(fstop))&&(~isnan(fpass))&&(fpass<fstop))
            if(strcmp(typeFilter,'FIR'))
                senalFiltrada  = signalOperator.lowpassFilter(senal,typeFilter,fpass,fstop);
            else
                senalFiltrada  = signalOperator.lowpassFilter(senal,typeFilter,fpass,fstop);
            end
            listaSenales = get(handles.listaSenales, 'String');
            cantSenales = cantSenales + 1;
            senales{cantSenales} = senalFiltrada;
            nuevaSenal = ['Se�al ' num2str(cantSenales) '(se�al ' num2str(nroSenal) ' filtrada)' ];
            listaSenales = char(listaSenales, nuevaSenal);
            set(handles.listaSenales, 'String', listaSenales);
        else
            msgbox('Poner valores correctos, recordar que que fpass<fstop');
        end
    elseif(strcmp(filter,'Filtrar(PB)'))
        contents = cellstr(get(handles.typeFilter, 'String'));
        typeFilter =contents(get(handles.typeFilter, 'Value'));
        fstop1 =  str2double(get(handles.valText1, 'String'));
        fpass1 =  str2double(get(handles.valText2, 'String'));
        fpass2 =  str2double(get(handles.valText3, 'String'));
        ftop2 =  str2double(get(handles.valText4, 'String'));
        if((~isnan(fstop1))&&(~isnan(fpass1))&&(~isnan(fpass2))&&(~isnan(fstop2)))
            if((fstop1<fpass1)&&(fpass1<fpass2)&&(fpass2<ftop2))
                if(strcmp(typeFilter,'FIR'))
                    senalFiltrada  = signalOperator.passbandFilter(senal,typeFilter,fstop1,fpass1,fpass2,fstop2);
                else
                    senalFiltrada  = signalOperator.passbandFilter(senal,typeFilter,fstop1,fpass1,fpass2,fstop2);
                end
                listaSenales = get(handles.listaSenales, 'String');
                cantSenales = cantSenales + 1;
                senales{cantSenales} = senalFiltrada;
                nuevaSenal = ['Se�al ' num2str(cantSenales) '(se�al ' num2str(nroSenal) ' filtrada)' ];
                listaSenales = char(listaSenales, nuevaSenal);
                set(handles.listaSenales, 'String', listaSenales);
            else
                 msgbox('Poner valores correctos, recordar que que fstop1<fpass1<fpass2<fstop2');
            end
        else
            msgbox('Poner valores correctos, recordar que que fstop1<fpass1<fpass2<fstop2');
        end
    elseif(strcmp(filter,'Filtrar(NB)'))
        contents = cellstr(get(handles.typeFilter, 'String'));
        typeFilter =contents(get(handles.typeFilter, 'Value'));
        fpass1 =  str2double(get(handles.valText1, 'String'));
        fstop1 =  str2double(get(handles.valText2, 'String'));
        ftop2 =  str2double(get(handles.valText3, 'String'));
        fpass2 =  str2double(get(handles.valText4, 'String'));
        if((~isnan(fstop1))&&(~isnan(fpass1))&&(~isnan(fpass2))&&(~isnan(fstop2)))
            if((fpass1<fstop1)&&(fstop1<ftop2)&&(ftop2<fpass2))
                if(strcmp(typeFilter,'FIR'))
                    senalFiltrada  = signalOperator.notchFilter(senal,typeFilter,fpass1,fstop1,fstop2,fpass2);
                else
                    senalFiltrada  = signalOperator.notchFilter(senal,typeFilter,fpass1,fstop1,fstop2,fpass2);
                end
                listaSenales = get(handles.listaSenales, 'String');
                cantSenales = cantSenales + 1;
                senales{cantSenales} = senalFiltrada;
                nuevaSenal = ['Se�al ' num2str(cantSenales) '(se�al ' num2str(nroSenal) ' filtrada)' ];
                listaSenales = char(listaSenales, nuevaSenal);
                set(handles.listaSenales, 'String', listaSenales);
            else
                 msgbox('Poner valores correctos, recordar que que fpass1<fstop1<fstop2<fpass2');
            end
        else
            msgbox('Poner valores correctos, recordar que que fstop1<fpass1<fpass2<fstop2');
        end
    elseif(strcmp(filter,'Filtrar(Deriv)'))
        n =  str2double(get(handles.valText4, 'String'));
        if((~isnan(n))&&(n > 0))
            senalFiltrada  = signalOperator.derivateFilter(senal,n);
            listaSenales = get(handles.listaSenales, 'String');
            cantSenales = cantSenales + 1;
            senales{cantSenales} = senalFiltrada;
            nuevaSenal = ['Se�al ' num2str(cantSenales) '(se�al ' num2str(nroSenal) ' filtrada)' ];
            listaSenales = char(listaSenales, nuevaSenal);
            set(handles.listaSenales, 'String', listaSenales);
        else
            msgbox('Poner un valor correcto de n');
        end
    elseif(strcmp(filter,'Filtrar(prom)'))
        n =  str2double(get(handles.valText4, 'String'));
        if((~isnan(n))&&(n > 0))
            senalFiltrada  = signalOperator.averageFilter(senal,n);
            listaSenales = get(handles.listaSenales, 'String');
            cantSenales = cantSenales + 1;
            senales{cantSenales} = senalFiltrada;
            nuevaSenal = ['Se�al ' num2str(cantSenales) '(se�al ' num2str(nroSenal) ' filtrada)' ];
            listaSenales = char(listaSenales, nuevaSenal);
            set(handles.listaSenales, 'String', listaSenales);
        else
            msgbox('Poner un valor correcto de n');
        end
    end
else
    msgbox('Se filtra una se�al a la vez');
end


% --- Executes during object deletion, before destroying properties.
function pushbutton7_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function offset_Callback(hObject, eventdata, handles)
% hObject    handle to offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of offset as text
%        str2double(get(hObject,'String')) returns contents of offset as a double


% --- Executes during object creation, after setting all properties.
function offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function desplazTemp_Callback(hObject, eventdata, handles)
% hObject    handle to desplazTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of desplazTemp as text
%        str2double(get(hObject,'String')) returns contents of desplazTemp as a double


% --- Executes during object creation, after setting all properties.
function desplazTemp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to desplazTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function valText1_Callback(hObject, eventdata, handles)
% hObject    handle to valText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valText1 as text
%        str2double(get(hObject,'String')) returns contents of valText1 as a double


% --- Executes during object creation, after setting all properties.
function valText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function valText2_Callback(hObject, eventdata, handles)
% hObject    handle to valText2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valText2 as text
%        str2double(get(hObject,'String')) returns contents of valText2 as a double


% --- Executes during object creation, after setting all properties.
function valText2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valText2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function valText3_Callback(hObject, eventdata, handles)
% hObject    handle to valText3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valText3 as text
%        str2double(get(hObject,'String')) returns contents of valText3 as a double


% --- Executes during object creation, after setting all properties.
function valText3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valText3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function valText4_Callback(hObject, eventdata, handles)
% hObject    handle to valText4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valText4 as text
%        str2double(get(hObject,'String')) returns contents of valText4 as a double


% --- Executes during object creation, after setting all properties.
function valText4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valText4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in typeFilter.
function typeFilter_Callback(hObject, eventdata, handles)
% hObject    handle to typeFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns typeFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from typeFilter


% --- Executes during object creation, after setting all properties.
function typeFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to typeFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end