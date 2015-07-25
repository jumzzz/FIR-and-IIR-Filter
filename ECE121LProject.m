function varargout = ECE121LProject(varargin)
% ECE121LPROJECT MATLAB code for ECE121LProject.fig
%      ECE121LPROJECT, by itself, creates a new ECE121LPROJECT or raises the existing
%      singleton*.
%
%      H = ECE121LPROJECT returns the handle to a new ECE121LPROJECT or the handle to
%      the existing singleton*.
%
%      ECE121LPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECE121LPROJECT.M with the given input arguments.
%
%      ECE121LPROJECT('Property','Value',...) creates a new ECE121LPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ECE121LProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECE121LProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECE121LProject

% Last Modified by GUIDE v2.5 03-Dec-2013 08:49:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECE121LProject_OpeningFcn, ...
                   'gui_OutputFcn',  @ECE121LProject_OutputFcn, ...
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


% --- Executes just before ECE121LProject is made visible.
function ECE121LProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECE121LProject (see VARARGIN)

% Choose default command line output for ECE121LProject
handles.output = hObject;

set(handles.playButton,'enable','off')           % Disabling
set(handles.fir,'value',0)                       % Disabling
set(handles.iir,'value',0)                       % Disabling   
set(handles.fir,'enable','off')                  % Disabling   
set(handles.iir,'enable','off')                  % Disabling
set(handles.lowPass,'enable','off')              % Disabling    
set(handles.highPass,'enable','off')             % Disabling   
set(handles.bandPass,'enable', 'off')            % Disabling   
set(handles.bandStop, 'enable', 'off')           % Disabling   
set(handles.filterGenerate,'enable', 'off')      % Disabling
set(handles.freqResp,'enable','off')             % Disabling
set(handles.poleZero,'enable', 'off')            % Disabling
set(handles.impulseResponse,'enable','off')      % Disabling
set(handles.playFiltered,'enable','off')         % Diabling

cla(handles.axes1, 'reset')                      % Clears axes1
cla(handles.axes2, 'reset')                      % Clears axes2                      
cla(handles.axes3, 'reset')                      % Clears axes3
cla(handles.axes4, 'reset')                      % Clears axes4   


set(handles.recordTimeInput,'enable','on')       % Enable for recordTime input
set(handles.fsInput,'enable','on')               % Enable for fsInput input
set(handles.recordButton, 'enable', 'on' )       % Enable for recordButton input
set(handles.filterOrder,'enable','on')           % Enable filter Order   
set(handles.cutOff1,'enable','on')               % Enable cutOff1
set(handles.cutOff2,'enable','on')               % Enable cutOff2   
set(handles.rpdB,'enable','on')                  % Enable Rp(dB)   
set(handles.rsdB,'enable','on')                  % Enable Rs(dB)

%% Declares Global Static Variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global fs
global recordtime
global cutoff1
global cutoff2
global RpdB
global RsdB
global norder


fs = get(handles.fsInput,'String');
fs = str2double(fs);

recordtime = get(handles.recordTimeInput,'String');
recordtime = str2double(recordtime);

norder = get(handles.filterOrder, 'String');
norder = str2double(norder);

cutoff1 = get(handles.cutOff1,'String');
cutoff1 = str2double(cutoff1);

cutoff2 = get(handles.cutOff2,'String');
cutoff2 = str2double(cutoff2);

RpdB = get(handles.rpdB,'String');
RpdB = str2double(RpdB);

RsdB = get(handles.rsdB, 'String');
RsdB = str2double(RsdB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ends here

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ECE121LProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECE121LProject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in recordButton.
function recordButton_Callback(hObject, eventdata, handles)
% hObject    handle to recordButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global fs
global record
global recordtime

wait = waitbar(0,'Voice Recording in Progress');
record = wavrecord(recordtime*fs,fs,'double');
close(wait);
wait = waitbar(1,'Record Complete');
pause(1);
close(wait);

set(handles.playButton,'enable','on')           % Enabling    
set(handles.fir,'enable','on')                  % Enabling 
set(handles.iir,'enable','on')                  % Enabling
set(handles.lowPass,'enable','on')              % Enabling    
set(handles.highPass,'enable','on')             % Enabling   
set(handles.bandPass,'enable', 'on')            % Enabling   
set(handles.bandStop, 'enable', 'on')           % Enabling   
set(handles.filterGenerate,'enable', 'on')      % Enabling


% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global record  
global fs
global play
wavplay(record,fs)


% --- Executes on button press in timeDomain.
function timeDomain_Callback(hObject, eventdata, handles)
% hObject    handle to timeDomain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global record

if(get(handles.timeDomain,'value')==1)
    plot(handles.axes1,record,'r'),xlabel(handles.axes1,'\bf Time (Seconds)'),ylabel(handles.axes1,'\bfAmplitude'),...
    title(handles.axes1, '\bfUnfiltered Signal Time Domain');
elseif (get(handles.timeDomain,'value') == 0)
    cla(handles.axes1, 'reset')
end
set(handles.axes1,'XGrid','on','YGrid','on')

% Hint: get(hObject,'Value') returns toggle state of timeDomain


% --- Executes on button press in freqDomain.
function freqDomain_Callback(hObject, eventdata, handles)
% hObject    handle to freqDomain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global record

fdrecord = fft(record,512);

if(get(handles.freqDomain,'value')==1)
    plot(handles.axes2,abs(fdrecord),'m'),xlabel(handles.axes2,'\bfFrequency(Hz)'),ylabel(handles.axes2,'\bfMagnitude'),...
    title(handles.axes2, '\bfUnfiltered Signal Frequency Domain');
elseif (get(handles.freqDomain,'value')==0)
    cla(handles.axes2, 'reset')
end
set(handles.axes2,'XGrid','on','YGrid','on')
% Hint: get(hObject,'Value') returns toggle state of freqDomain



function recordTimeInput_Callback(hObject, eventdata, handles)
% hObject    handle to recordTimeInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recordTimeInput as text
%        str2double(get(hObject,'String')) returns contents of recordTimeInput as a double


% --- Executes during object creation, after setting all properties.
function recordTimeInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recordTimeInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fsInput_Callback(hObject, eventdata, handles)
% hObject    handle to fsInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fsInput as text
%        str2double(get(hObject,'String')) returns contents of fsInput as a double


% --- Executes during object creation, after setting all properties.
function fsInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fsInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fir.
function fir_Callback(hObject, eventdata, handles)
% hObject    handle to fir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(get(handles.fir,'value')==1)
    set(handles.iir,'value',0)                          %disable iir button
    set(handles.butterWorth,'enable','off')             %disable
    set(handles.chebyshev,'enable','off')               %disable
    set(handles.elliptic,'enable','off')                %disable
    set(handles.rpdB, 'enable', 'off')                  %disable    
    set(handles.rsdB, 'enable', 'off')                  %disable
    
    
    set(handles.freqResp,'enable','on')             % Enabling
    set(handles.poleZero,'enable', 'on')            % Enabling
    set(handles.impulseResponse,'enable','on')      % Enabling
    
end
        


% Hint: get(hObject,'Value') returns toggle state of fir


% --- Executes on button press in iir.
function iir_Callback(hObject, eventdata, handles)
% hObject    handle to iir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.iir,'value')==1)
    set(handles.fir,'value',0)
    set(handles.butterWorth,'enable','on') %Enabling
    set(handles.chebyshev,'enable','on')   %Enabling
    set(handles.elliptic,'enable','on')    %Enabling     
    set(handles.rpdB, 'enable', 'on')      %Enabling 
    set(handles.rsdB, 'enable', 'on')      %Enabling 
    
    set(handles.freqResp,'enable','on')             % Enabling
    set(handles.poleZero,'enable', 'on')            % Enabling
    set(handles.impulseResponse,'enable','on')      % Enabling
    
    
    
end
% Hint: get(hObject,'Value') returns toggle state of iir


% --- Executes on button press in lowPass.
function lowPass_Callback(hObject, eventdata, handles)
% hObject    handle to lowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if(get(handles.lowPass,'value')==1)             %If lowPass is selected
    set(handles.highPass,'value',0)             %Unselectable
    set(handles.bandPass,'value',0)             %Unselectable   
    set(handles.bandStop,'value',0)             %Unselectable
    set(handles.cutOff2, 'enable', 'off')       %Disabling    
    
    set(handles.cutOff1, 'enable' ,'on')        %Enabling
    set(handles.filterOrder, 'enable' , 'on')   %Enabling
 
end
% Hint: get(hObject,'Value') returns toggle state of lowPass


% --- Executes on button press in highPass.
function highPass_Callback(hObject, eventdata, handles)
% hObject    handle to highPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(get(handles.highPass,'value')==1)           
    set(handles.lowPass,'value', 0)             %Unselectable
    set(handles.bandPass,'value', 0)            %Unselectable
    set(handles.bandStop, 'value', 0)           %Unselectable     
    set(handles.cutOff2, 'enable', 'off')       %Disabling     
    
    set(handles.cutOff1, 'enable' ,'on')        %Enabling
    set(handles.filterOrder, 'enable' , 'on')   %Enabling

end
% Hint: get(hObject,'Value') returns toggle state of highPass


% --- Executes on button press in bandPass.
function bandPass_Callback(hObject, eventdata, handles)
% hObject    handle to bandPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(get(handles.bandPass,'value')==1)
    set(handles.lowPass,'value', 0)            %Unselectable
    set(handles.highPass,'value', 0)           %Unselectable 
    set(handles.bandStop, 'value', 0)          %Unselectable 
    set(handles.cutOff2, 'enable', 'on')       %Enables cutOff2
    
    set(handles.cutOff1, 'enable' ,'on')        %Enabling
    set(handles.filterOrder, 'enable' , 'on')   %Enabling
    
end

% Hint: get(hObject,'Value') returns toggle state of bandPass


% --- Executes on button press in bandStop.
function bandStop_Callback(hObject, eventdata, handles)
% hObject    handle to bandStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(get(handles.bandStop,'value')==1)           % 
    set(handles.lowPass,'value', 0)            %Unselectable 
    set(handles.highPass,'value', 0)           %Unselectable 
    set(handles.bandPass, 'value', 0)          %Unselectable 
    set(handles.cutOff2, 'enable', 'on')
    
    set(handles.cutOff1, 'enable' ,'on')        %Enabling
    set(handles.filterOrder, 'enable' , 'on')   %Enabling
    
end
% Hint: get(hObject,'Value') returns toggle state of bandStop



function filterOrder_Callback(hObject, eventdata, handles)
% hObject    handle to filterOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global norder
norder = str2double(handles.filterOrder);

% Hints: get(hObject,'String') returns contents of filterOrder as text
%        str2double(get(hObject,'String')) returns contents of filterOrder as a double


% --- Executes during object creation, after setting all properties.
function filterOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cutOff1_Callback(hObject, eventdata, handles)
% hObject    handle to cutOff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutOff1 as text
%        str2double(get(hObject,'String')) returns contents of cutOff1 as a double


% --- Executes during object creation, after setting all properties.
function cutOff1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutOff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cutOff2_Callback(hObject, eventdata, handles)
% hObject    handle to fc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fc2 as text
%        str2double(get(hObject,'String')) returns contents of fc2 as a double


% --- Executes during object creation, after setting all properties.
function cutOff2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rpdB_Callback(hObject, eventdata, handles)
% hObject    handle to rpdB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rpdB as text
%        str2double(get(hObject,'String')) returns contents of rpdB as a double


% --- Executes during object creation, after setting all properties.
function rpdB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rpdB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rsdB_Callback(hObject, eventdata, handles)
% hObject    handle to rsdB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rsdB as text
%        str2double(get(hObject,'String')) returns contents of rsdB as a double


% --- Executes during object creation, after setting all properties.
function rsdB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rsdB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in butterWorth.
function butterWorth_Callback(hObject, eventdata, handles)
% hObject    handle to butterWorth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.butterWorth,'value')==1)
    set(handles.chebyshev,'value', 0)   %Deselecting
    set(handles.elliptic,'value', 0)    %Deselecting   
    
end
    

% Hint: get(hObject,'Value') returns toggle state of butterWorth


% --- Executes on button press in chebyshev.
function chebyshev_Callback(hObject, eventdata, handles)
% hObject    handle to chebyshev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.chebyshev,'value')==1)
    set(handles.butterWorth,'value', 0)    %Deselecting
    set(handles.elliptic,'value', 0)       %Deselecting   
    
end

% Hint: get(hObject,'Value') returns toggle state of chebyshev


% --- Executes on button press in elliptic.
function elliptic_Callback(hObject, eventdata, handles)
% hObject    handle to elliptic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(get(handles.elliptic,'value')==1)
    set(handles.butterWorth,'value', 0)   %Deselecting
    set(handles.chebyshev,'value', 0)     %Deselecting   
    
end
% Hint: get(hObject,'Value') returns toggle state of elliptic


% --- Executes on button press in freqDomainFiltered.
function freqDomainFiltered_Callback(hObject, eventdata, handles)
% hObject    handle to freqDomainFiltered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of freqDomainFiltered


% --- Executes on button press in filterGenerate.
function filterGenerate_Callback(hObject, eventdata, handles)
% hObject    handle to filterGenerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global record
global fs
global cutoff1
global cutoff2
global norder
global RpdB
global RsdB
global bfilter
global afilter
global filteredrecord;
global titleholder;

if (get(handles.fir,'value')==1)&&(get(handles.lowPass,'value')==1)
    
    titleholder = '\bf FIR Low Pass Filter';
    
    wn = cutoff1/(fs/2);
    b = fir1(norder,wn,'low');
    a = 1;
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x,512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf  FIR Low Pass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bf Frequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf  FIR Low Pass Frequency Domain Representation');
    
elseif (get(handles.fir,'value')==1)&&(get(handles.highPass,'value')==1)
    
    titleholder = '\bf FIR High Pass Filter';
    
    wn = cutoff1/(fs/2);
    b = fir1(norder,wn,'high');
    a = 1;
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x,512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf  FIR High Pass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf  FIR High Pass Frequency Domain Representation');
    
elseif (get(handles.fir,'value')==1)&&(get(handles.bandPass,'value')==1)  
   
   titleholder = '\bf FIR Bandpass Filter';
    
   wn1 = cutoff1/(fs/2);
   wn2 = cutoff2/(fs/2);
   b = fir1(norder,[wn1 wn2], 'bandpass');
   a= 1;
   
   bfilter = b;
   afilter = a;
  
   x = filter(b,a,record);
   filteredrecord = x;
   
   ffx = fft(x, 512);
   plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
   title(handles.axes3, '\bf  FIR Bandpass Time Domain Representation');
   plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
   title(handles.axes4, '\bf  FIR Bandpass Frequency Domain Representation');
    
elseif (get(handles.fir,'value')==1)&&(get(handles.bandStop,'value')==1)   
   
   titleholder = '\bf FIR Bandstop Filter'; 
    
   wn1 = cutoff1/(fs/2);
   wn2 = cutoff2/(fs/2);
   b = fir1(norder,[wn1 wn2], 'stop');
   a= 1;
   
   bfilter = b;
   afilter = a;
   
   x = filter(b,a,record);
   filteredrecord = x;
   
   ffx = fft(x, 512);
   plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
   title(handles.axes3, '\bf  FIR Bandstop Time Domain Representation');
   plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
   title(handles.axes4, '\bf  FIR Bandstop Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.lowPass,'value')==1)&&(get(handles.butterWorth,'value')==1)
   
    titleholder = '\bf Butterworth Low Pass Filter';
    wp = cutoff1/fs;
    ws = cutoff2/fs;
    [n,wn] = buttord(wp,ws,RpdB,RsdB);
    [b,a] = butter(n,wn,'low');
    
    bfilter = b;
    afilter = a;
    
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Butterworth Low Pass  Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Butterworth Low Pass Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.highPass,'value')==1)&&(get(handles.butterWorth,'value')==1)
   
    titleholder = '\bf Butterworth High Pass Filter';
    wp = cutoff1/fs;
    ws = cutoff2/fs;
    [n,wn] = buttord(wp,ws,RpdB,RsdB);
    [b,a] = butter(n,wn,'high');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Butterworth High Pass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Butterworth High Pass Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.bandPass,'value')==1)&&(get(handles.butterWorth,'value')==1)
   
    titleholder = '\bf Butterworth Bandpass Filter';
    
    wp = [0.3 1].*(cutoff1/fs);
    ws =  [0.1 1].*(cutoff2/fs);
    [n,wn] = buttord(ws,wp,RpdB,RsdB);
    [b,a] = butter(n,wn,'bandpass');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    handles.filterOrder = num2str(n);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Butterworth Bandpass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Butterworth Bandpass Frequency Domain Representation');



elseif (get(handles.iir,'value')==1)&&(get(handles.bandStop,'value')==1)&&(get(handles.butterWorth,'value')==1)
   
    titleholder = '\bf Butterworth Bandstop';
    
    wp = [0.3 1].*(cutoff1/fs);
    ws =  [0.1 1].*(cutoff2/fs);
    [n,wn] = buttord(wp,ws,RpdB,RsdB);
    [b,a] = butter(n,wn,'stop');
    
    bfilter = b;
    afilter = a;
   
 
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    handles.filterOrder = num2str(n);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Butterworth Bandstop Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Butterworth Bandstop Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.lowPass,'value')==1)&&(get(handles.chebyshev,'value')==1)
   
    titleholder = '\bf Chebyshev Low Pass Filter';
    
    wp = cutoff1/fs;
    ws = cutoff2/fs;
    [n,wn] = cheb1ord(wp,ws,RpdB,RsdB);
    [b,a] = cheby1(n,RpdB,wn,'low');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Chebyshev Low Pass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Chebyshev Low Pass Frequency Domain Representation');


elseif (get(handles.iir,'value')==1)&&(get(handles.highPass,'value')==1)&&(get(handles.chebyshev,'value')==1)
   
    titleholder = '\bf Chebyshev High Pass Filter';
    wp = cutoff1/fs;
    ws = cutoff2/fs;
    [n,wn] = cheb1ord(wp,ws,RpdB,RsdB);
    [b,a] = cheby1(n,RpdB,wn,'high');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Chebyshev High Pass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Chebyshev High Pass Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.bandPass,'value')==1)&&(get(handles.chebyshev,'value')==1)
   
    titleholder = '\bf Chebyshev Bandpass Filter';
    
    wp = [0.3 1].*(cutoff1/fs);
    ws =  [0.1 1].*(cutoff2/fs);
    [n,wn] = cheb1ord(wp,ws,RpdB,RsdB);
    [b,a] = cheby1(n,RpdB,wn,'bandpass');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    handles.filterOrder = num2str(n);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Chebyshev Bandpass  Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Chebyshev Bandpass Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.bandStop,'value')==1)&&(get(handles.chebyshev,'value')==1)
   
    titleholder = '\bf Chebyshev Bandstop';
    
    wp = [0.3 1].*(cutoff1/fs);
    ws =  [0.1 1].*(cutoff2/fs);
    [n,wn] = cheb1ord(wp,ws,RpdB,RsdB);
    [b,a] = cheby1(n,RpdB,wn,'stop');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    handles.filterOrder = num2str(n);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Chebyshev Bandstop Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Chebyshev Bandstop Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.lowPass,'value')==1)&&(get(handles.elliptic,'value')==1)

    titleholder = '\bf Elliptical Low Pass Filter';
    
    wp = cutoff1/fs;
    ws = cutoff2/fs;
    [n,wn] = ellipord(wp,ws,RpdB,RsdB);
    [b,a] = ellip(n,RpdB,RsdB,wn,'low');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Elliptic Low Pass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Elliptic Low Pass Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.highPass,'value')==1)&&(get(handles.elliptic,'value')==1)
   
    titleholder = '\bf Elliptical High Pass Filter';
    
    wp = cutoff1/fs;
    ws = cutoff2/fs;
    [n,wn] = ellipord(wp,ws,RpdB,RsdB);
    [b,a] = ellip(n,RpdB,RsdB,wn,'high');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Elliptic High Pass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Elliptic High Pass Frequency Domain Representation');


elseif (get(handles.iir,'value')==1)&&(get(handles.bandPass,'value')==1)&&(get(handles.elliptic,'value')==1)
   
    titleholder = '\bf Elliptical Bandpass Filter'
    
    wp = [0.3 1].*(cutoff1/fs);
    ws =  [0.1 1].*(cutoff2/fs);
    [n,wn] = ellipord(wp,ws,RpdB,RsdB);
    [b,a] = ellip(n,RpdB,RsdB,wn,'bandpass');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Elliptic Bandpass Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Elliptic Bandpass Frequency Domain Representation');

elseif (get(handles.iir,'value')==1)&&(get(handles.bandStop,'value')==1)&&(get(handles.elliptic,'value')==1)
   
    titleholder = '\bf Elliptical Bandstop';
    wp = [0.3 1].*(cutoff1/fs);
    ws =  [0.1 1].*(cutoff2/fs);
    [n,wn] = ellipord(wp,ws,RpdB,RsdB);
    [b,a] = ellip(n,RpdB,RsdB,wn,'stop');
    
    bfilter = b;
    afilter = a;
   
    x = filter(b,a,record);
    filteredrecord = x;
    
    ffx = fft(x, 512);
    plot(handles.axes3,x),xlabel(handles.axes3,'\bf Time (Seconds)'),ylabel(handles.axes3,'\bf Amplitude'),...
    title(handles.axes3, '\bf Elliptic Bandstop Time Domain Representation');
    plot(handles.axes4,abs(ffx),'g'),xlabel(handles.axes4,'\bfFrequency(Hz)'),ylabel(handles.axes4,'\bfMagnitude'),...
    title(handles.axes4, '\bf Elliptic Bandstop Frequency Domain Representation');

end
set(handles.playFiltered,'enable','on')
set(handles.axes3,'XGrid','on','YGrid','on')
set(handles.axes4,'XGrid','on','YGrid','on')
% Hint: get(hObject,'Value') returns toggle state of filterGenerate


% --------------------------------------------------------------------
function uipanel1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in freqResp.
function freqResp_Callback(hObject, eventdata, handles)
% hObject    handle to freqResp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bfilter
global afilter
global fig1
global titleholder
fig1 = figure(1);
freqz(bfilter,afilter,512,1000),title(titleholder)



% --- Executes on button press in poleZero.
function poleZero_Callback(hObject, eventdata, handles)
% hObject    handle to poleZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bfilter
global afilter
global fig2
global titleholder

fig2 = figure(2);
zplane(bfilter,afilter),title(titleholder)


% --- Executes on button press in impulseResponse.
function impulseResponse_Callback(hObject, eventdata, handles)
% hObject    handle to impulseResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bfilter
global afilter
global fig3
global titleholder

fig3 = figure(3);
impz(bfilter,afilter),title(titleholder)


% --- Executes on button press in closeFigure.
function closeFigure_Callback(hObject, eventdata, handles)
% hObject    handle to closeFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fig1
global fig2
global fig3

close(fig1)
close(fig2)
close(fig3)


% --- Executes on button press in clearPlot.
function clearPlot_Callback(hObject, eventdata, handles)
% hObject    handle to clearPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1, 'reset')
cla(handles.axes2, 'reset')
cla(handles.axes3, 'reset')
cla(handles.axes4, 'reset')


% --- Executes on button press in playFiltered.
function playFiltered_Callback(hObject, eventdata, handles)
% hObject    handle to playFiltered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filteredrecord
global fs
wavplay(filteredrecord,fs)
