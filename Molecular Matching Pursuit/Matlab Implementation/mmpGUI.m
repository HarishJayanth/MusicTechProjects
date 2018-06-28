function varargout = mmpGUI(varargin)
% MMPGUI MATLAB code for mmpGUI.fig
%      MMPGUI, by itself, creates a new MMPGUI or raises the existing
%      singleton*.
%
%      H = MMPGUI returns the handle to a new MMPGUI or the handle to
%      the existing singleton*.
%
%      MMPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MMPGUI.M with the given input arguments.
%
%      MMPGUI('Property','Value',...) creates a new MMPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mmpGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mmpGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mmpGUI

% Last Modified by GUIDE v2.5 01-May-2018 20:04:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mmpGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mmpGUI_OutputFcn, ...
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


% --- Executes just before mmpGUI is made visible.
function mmpGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mmpGUI (see VARARGIN)

% Choose default command line output for mmpGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mmpGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mmpGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in preEchoSuppression.
function preEchoSuppression_Callback(hObject, eventdata, handles)
% hObject    handle to preEchoSuppression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of preEchoSuppression


% --- Executes on button press in pb_play_input.
function pb_play_input_Callback(hObject, eventdata, handles)
% hObject    handle to pb_play_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function winLength_Callback(hObject, eventdata, handles)
% hObject    handle to winLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of winLength as text
%        str2double(get(hObject,'String')) returns contents of winLength as a double


% --- Executes during object creation, after setting all properties.
function winLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dwtCoeffThresh_Callback(hObject, eventdata, handles)
% hObject    handle to dwtCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dwtCoeffThresh as text
%        str2double(get(hObject,'String')) returns contents of dwtCoeffThresh as a double


% --- Executes during object creation, after setting all properties.
function dwtCoeffThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dwtCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mdctCoeffThresh_Callback(hObject, eventdata, handles)
% hObject    handle to mdctCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mdctCoeffThresh as text
%        str2double(get(hObject,'String')) returns contents of mdctCoeffThresh as a double


% --- Executes during object creation, after setting all properties.
function mdctCoeffThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mdctCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function persistence_Callback(hObject, eventdata, handles)
% hObject    handle to persistence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of persistence as text
%        str2double(get(hObject,'String')) returns contents of persistence as a double


% --- Executes during object creation, after setting all properties.
function persistence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to persistence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gamma_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio_Callback(hObject, eventdata, handles)
% hObject    handle to ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio as text
%        str2double(get(hObject,'String')) returns contents of ratio as a double


% --- Executes during object creation, after setting all properties.
function ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in computeButton.
function computeButton_Callback(hObject, eventdata, handles)
% hObject    handle to computeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


TmaxThresh = str2num(get(handles.TmaxThresh,'String'));
assignin('base','TmaxThresh',TmaxThresh);
winLen = str2num(get(handles.winLength,'String'));
assignin('base','winLen',winLen);
mdctCoeffThresh = str2num(get(handles.mdctCoeffThresh,'String'));
assignin('base','mdctCoeffThresh',mdctCoeffThresh);
fs = evalin('base', 'fs');
W = (2*str2num(get(handles.persistence,'String'))*fs/winLen);
assignin('base','W',W);

ratio = str2num(get(handles.ratio,'String'));
assignin('base','ratio',ratio);

KmaxThresh = str2num(get(handles.KmaxThresh,'String'));
assignin('base','KmaxThresh',KmaxThresh);
wtCoeffThresh = str2num(get(handles.wtCoeffThresh,'String'));
assignin('base','wtCoeffThresh',wtCoeffThresh);
gamma = str2num(get(handles.gamma,'String'));
assignin('base','gamma',gamma);

preEchoSuppression = get(handles.preEchoSuppression, 'Value');
assignin('base','preEchoSuppression',preEchoSuppression);

set(handles.statusTextbox, 'String', 'Performing molecular matching pursuit...');
% set(handles.statusTextbox, 'String', 'Blah!!!');
pause(1);
[transient_signal, tonal_signal, res] = molecular_matching_pursuit();
assignin('base','transient_signal',transient_signal);
assignin('base','tonal_signal',tonal_signal);
assignin('base','res',res);
t = 0: 1/fs :(size(transient_signal,1)-1)/fs;
set(handles.statusTextbox, 'String', 'Done!');

x = evalin('base','x');

axes(handles.transientSignalPlot);
plot(handles.transientSignalPlot, t, transient_signal);
axis([0, t(end), min(x), max(x)]);

axes(handles.tonalSignalPlot);
plot(handles.tonalSignalPlot, t, tonal_signal);
axis([0, t(end), min(x), max(x)]);

axes(handles.residualSignalPlot);
plot(handles.residualSignalPlot, t, res);
axis([0, t(end), min(x), max(x)]);

function wtCoeffThresh_Callback(hObject, eventdata, handles)
% hObject    handle to wtCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wtCoeffThresh as text
%        str2double(get(hObject,'String')) returns contents of wtCoeffThresh as a double


% --- Executes during object creation, after setting all properties.
function wtCoeffThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wtCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KmaxThresh_Callback(hObject, eventdata, handles)
% hObject    handle to KmaxThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KmaxThresh as text
%        str2double(get(hObject,'String')) returns contents of KmaxThresh as a double


% --- Executes during object creation, after setting all properties.
function KmaxThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KmaxThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to winLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of winLength as text
%        str2double(get(hObject,'String')) returns contents of winLength as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to mdctCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mdctCoeffThresh as text
%        str2double(get(hObject,'String')) returns contents of mdctCoeffThresh as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mdctCoeffThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to persistence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of persistence as text
%        str2double(get(hObject,'String')) returns contents of persistence as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to persistence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TmaxThresh_Callback(hObject, eventdata, handles)
% hObject    handle to TmaxThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TmaxThresh as text
%        str2double(get(hObject,'String')) returns contents of TmaxThresh as a double


% --- Executes during object creation, after setting all properties.
function TmaxThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TmaxThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in openFile.
function openFile_Callback(hObject, eventdata, handles)
% hObject    handle to openFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename path] = uigetfile({'*.wav'},'Open Sound File');
[x, fs] = audioread(strcat(path,filename));
assignin('base','fs',fs);
x = x(:,1);
assignin('base','x',x);
t = [0: 1/fs :(size(x,1)-1)/fs];
% axes(handles.inputSignalPlot);
plot(handles.inputSignalPlot,t,x);
axis([min(x), max(x), 0, t(end)]);
axes(handles.tonalSignalPlot);
cla reset;
axes(handles.transientSignalPlot);
cla reset;
axes(handles.residualSignalPlot);
cla reset;
set(handles.statusTextbox, 'String', 'Enter parameters and click "Compute"');


% --- Executes on button press in clearPlots.
function clearPlots_Callback(hObject, eventdata, handles)
% hObject    handle to clearPlots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.tonalSignalPlot);
cla reset;
axes(handles.transientSignalPlot);
cla reset;
axes(handles.residualSignalPlot);
cla reset;
set(handles.statusTextbox, 'String', 'Enter parameters and click "Compute"');


% --- Executes on button press in inputSignalPlay.
function inputSignalPlay_Callback(hObject, eventdata, handles)
% hObject    handle to inputSignalPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = evalin('base','x');
fs = evalin('base','fs');
sound(x,fs);

% --- Executes on button press in tonalSignalPlay.
function tonalSignalPlay_Callback(hObject, eventdata, handles)
% hObject    handle to tonalSignalPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = evalin('base','tonal_signal');
fs = evalin('base','fs');
sound(x,fs);

% --- Executes on button press in residualSignalPlay.
function residualSignalPlay_Callback(hObject, eventdata, handles)
% hObject    handle to residualSignalPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = evalin('base','res');
fs = evalin('base','fs');
sound(x,fs);

% --- Executes on button press in transientSignalPlay.
function transientSignalPlay_Callback(hObject, eventdata, handles)
% hObject    handle to transientSignalPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = evalin('base','transient_signal');
fs = evalin('base','fs');
sound(x,fs);
