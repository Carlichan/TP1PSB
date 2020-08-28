function varargout = TP1GUI(varargin)
% TP1GUI MATLAB code for TP1GUI.fig
%      TP1GUI, by itself, creates a new TP1GUI or raises the existing
%      singleton*.
%
%      H = TP1GUI returns the handle to a new TP1GUI or the handle to
%      the existing singleton*.
%
%      TP1GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TP1GUI.M with the given input arguments.
%
%      TP1GUI('Property','Value',...) creates a new TP1GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TP1GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TP1GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TP1GUI

% Last Modified by GUIDE v2.5 20-Aug-2020 15:10:07

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


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
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
sin = get(handles.sin,'Value');
square = get(handles.square,'Value');
triangle = get(handles.triangle,'Value');
dc = str2double(get(handles.dc, 'String'));
frequency = str2double(get(handles.frec, 'String'));
phase = str2double(get(handles.phase, 'String'));
amplitude = str2double(get(handles.amplitude, 'String'));
tmin =  str2double(get(handles.tmin, 'String'));
tmax =  str2double(get(handles.tmax, 'String'));
signalGenerator = SignalGenerator(1e5, tmin, tmax);

if sin == 1
[signal_t, signal_f] = signalGenerator.generateSinusoidal(frecuency,amplitude,phase);
elseif square == 1
[signal_t, signal_f] = signalGenerator.generateSquare(frecuency,amplitude,dc);
elseif triangle == 1
[signal_t, signal_f] = signalGenerator.generateTriangular(amplitude,frecuency,dc);
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
