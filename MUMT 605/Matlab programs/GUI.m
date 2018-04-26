function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 17-Dec-2017 13:51:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in openFile.
function openFile_Callback(hObject, eventdata, handles)
% hObject    handle to openFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename path] = uigetfile({'*.mp3'},'Open Sound File');
    [x, fs] = audioread(strcat(path,filename));
    assignin('base','fs',fs);
    x = x(:,1);
    assignin('base','x',x);
    axes(handles.plot1);
    t = [0: 1/fs :(size(x,1)-1)/fs];
    plot(t,x);




function poles_Callback(hObject, eventdata, handles)
% hObject    handle to poles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poles as text
%        str2double(get(hObject,'String')) returns contents of poles as a double


% --- Executes during object creation, after setting all properties.
function poles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poles (see GCBO)
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
    x = evalin('base', 'x');
    fs = evalin('base', 'fs');
    p = str2num(get(handles.poles,'String'));
    assignin('base', 'p', p);
    [E,a,g] = lpcAnalysis(x,p);
    semitone = str2num(get(handles.semitones, 'String'));
    E = pitchShift(E, semitone);
    y = lpcSynthesis(E,a,g);
    assignin('base', 'E', E);
    assignin('base', 'a', a);
    assignin('base', 'g', g);
    assignin('base', 'y', y);
    axes(handles.plot2);
    t = [0: 1/fs :(size(x,1)-1)/fs];
    plot(t,E(1:size(x,1)));
    axes(handles.plot3);
    t = [0: 1/fs :(size(x,1)-1)/fs];
    plot(t,y(1:size(x,1)));
    



% --- Executes on button press in playX.
function playX_Callback(hObject, eventdata, handles)
% hObject    handle to playX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    x = evalin('base', 'x');
    fs = evalin('base', 'fs');
    sound(x,fs);


% --- Executes on button press in playY.
function playY_Callback(hObject, eventdata, handles)
% hObject    handle to playY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    y = evalin('base', 'y');
    fs = evalin('base', 'fs');
    sound(y,fs);

% --- Executes on button press in playE.
function playE_Callback(hObject, eventdata, handles)
% hObject    handle to playE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    E = evalin('base', 'E');
    fs = evalin('base', 'fs');
    sound(E,fs);


function semitones_Callback(hObject, eventdata, handles)
% hObject    handle to semitones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of semitones as text
%        str2double(get(hObject,'String')) returns contents of semitones as a double


% --- Executes during object creation, after setting all properties.
function semitones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to semitones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dispSpec.
function dispSpec_Callback(hObject, eventdata, handles)
% hObject    handle to dispSpec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    x = evalin('base', 'x');
    fs = evalin('base', 'fs');
    p = evalin('base', 'p');
    fftSize = evalin('base', 'fftSize');
    time = str2double(get(handles.tSpec, 'String'));
    time = time * fs;
    x = x(time:time+fftSize-1);
    X = 20*log10(abs(fft(x,fftSize)));
    R = xcorr(x);
    R = R(fftSize:end);
    a = levinson(R,p);
    g = sqrt(R(1) + sum(a(2:end)'.*R(2:p+1)));
    e = (x - filter([0 -a(2:end)], 1, x))/1;
    semitone = str2num(get(handles.semitones, 'String'));
    e = pitchShift(e, semitone);
    E = 20*log10(abs(fft(e,fftSize)));
    y = filter(1, a, e);
    Y = 20*log10(abs(fft(y,fftSize)));
    %figure;
    filtResp = filter(1,a,[1; zeros(fftSize-1,1)]);
    filtResp = 20*log10(abs(fft(filtResp,fftSize)));
    
    figure;
    subplot(1,2,1);
    plot([0:(fs/fftSize):(fs/2)-(fs/fftSize)],X(1:fftSize/2));
    title('Input and Spectral Estimation'); 
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    hold on;
    plot([0:(fs/fftSize):(fs/2)-(fs/fftSize)],filtResp(1:fftSize/2), 'black', 'LineWidth' , 1.5);
    legend('Input', 'Spectral Estimation');
    subplot(1,2,2);
    plot([0:(fs/fftSize):(fs/2)-(fs/fftSize)],Y(1:fftSize/2));
    title('Output');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    



function tSpec_Callback(hObject, eventdata, handles)
% hObject    handle to tSpec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tSpec as text
%        str2double(get(hObject,'String')) returns contents of tSpec as a double


% --- Executes during object creation, after setting all properties.
function tSpec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tSpec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in spectrogramDisp.
function spectrogramDisp_Callback(hObject, eventdata, handles)
% hObject    handle to spectrogramDisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    x = evalin('base', 'x');
    E = evalin('base', 'E');
    y = evalin('base', 'y');
    figure;
    subplot(3,1,1);
    spectrogram(x,1024);
    title('Input');
    xlabel('Frequency');
    view([90 -90]);
    subplot(3,1,2);
    spectrogram(E(1:size(x,1)),1024);
    title('Error');
    xlabel('Frequency');
    view([90 -90]);
    subplot(3,1,3);
    spectrogram(y(1:size(x,1)),1024);
    title('Output');
    xlabel('Frequency');
    view([90 -90]);
