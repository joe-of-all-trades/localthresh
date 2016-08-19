function varargout = localthreshGUI(varargin)
% LOCALTHRESHGUI MATLAB code for localthreshGUI.fig
%  User can use this GUI to quickly find optimal parameter for
%  localthresholding. Upon existing the GUI, the parameters users last set
%  will be returned if user specify an output variable.
%
%  bw = localthreshGUI(img) starts a graphical user interface and
%  display original image and a binary image as a result of
%  localthresholding of the original. Upon existing the GUI, binary image
%  will be returned as a result.
%
%  [bw, params] = localthreshGUI(img) returns parameters used for 
%  localthresholding in addition to the binary image.
%
%
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help localthreshGUI

% Last Modified by GUIDE v2.5 18-Aug-2016 19:31:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @localthreshGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @localthreshGUI_OutputFcn, ...
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


function localthreshGUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.img = varargin{1};
set(handles.figure1,'CurrentAxes',handles.axes1); 
axis off
handles.imh1 = imshow(handles.img, []);
imgisgray = length(size(handles.img)) == 2;
% set display range if img is grayscale
if imgisgray
    set(handles.edit_displaylow, 'string', num2str(min(handles.img(:))))
    set(handles.edit_displayhigh, 'string', num2str(max(handles.img(:))))
end
handles.bw = localthresh(handles.img, 3, 3, 1, 1);
set(handles.figure1, 'CurrentAxes', handles.axes2)
axis off
handles.imh2 = imshow(handles.bw);

handles.output = 'success';
guidata(hObject, handles);
% This will set the waitstatus to 'waiting' and is necessary to generate
% output.
uiwait(handles.figure1);


function varargout = localthreshGUI_OutputFcn(hObject, eventdata, handles)
if nargout >= 1
    varargout{1} = handles.bw;
end
if nargout == 2 
    varargout{2}.ssize = str2double(get(handles.edit_ssize, 'string'));
    varargout{2}.msize = str2double(get(handles.edit_msize, 'string'));
    varargout{2}.sthresh = get(handles.slider_sthresh, 'value');
    varargout{2}.mthresh = get(handles.slider_mthresh, 'value');
end
delete(handles.figure1);


function slider_mthresh_Callback(hObject, eventdata, handles)
handles.bw = localthresh(handles.img, str2double(get(handles.edit_ssize, 'string')),...
    str2double(get(handles.edit_msize, 'string')), ...
    get(handles.slider_sthresh, 'value'), get(hObjbect, 'value'));
set(handles.edit_mthresh, 'string', num2str(get(hObjbect, 'value')));
% setting CData is faster than redo imshow since other properties are not
% updated.
set(handles.imh2, 'CData', handles.bw);
guidata(hObject, handles);r


function slider_mthresh_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit_msize_Callback(hObject, eventdata, handles)
handles.bw = localthresh(handles.img, str2double(get(handles.edit_ssize, 'string')),...
    str2double(get(hObject, 'string')), get(handles.slider_sthresh, 'value'), ...
    get(handles.slider_mthresh, 'value'));
set(handles.imh2, 'CData', handles.bw);
guidata(hObject, handles);


function edit_msize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mthresh_Callback(hObject, eventdata, handles)
handles.bw = localthresh(handles.img, str2double(get(handles.edit_ssize, 'string')),...
    str2double(get(handles.edit_msize, 'string')), ...
    get(handles.slider_sthresh, 'value'), str2double(get(hObject, 'string')));
set(handles.slider_mthresh, 'value', str2double(get(hObject, 'string')));
set(handles.imh2, 'CData', handles.bw);
guidata(hObject, handles);


function edit_mthresh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function slider_sthresh_Callback(hObject, eventdata, handles)
handles.bw = localthresh(handles.img, str2double(get(handles.edit_ssize, 'string')),...
    str2double(get(handles.edit_msize, 'string')), get(hObject, 'value'), ...
    get(handles.slider_mthresh, 'value'));
set(handles.edit_mthresh, 'string', num2str(get(hObject, 'value')));
set(handles.imh2, 'CData', handles.bw);
guidata(hObject, handles);


function slider_sthresh_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edit_sthresh_Callback(hObject, eventdata, handles)
handles.bw = localthresh(handles.img, str2double(get(handles.edit_ssize, 'string')),...
    str2double(get(handles.edit_msize, 'string')), ...
    str2double(get(hObject, 'string')), get(handles.slider_mthresh, 'value'));
set(handles.slider_sthresh, 'value', str2double(get(hObject, 'string')));
set(handles.imh2, 'CData', handles.bw);
guidata(hObject, handles);


function edit_sthresh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_ssize_Callback(hObject, eventdata, handles)
handles.bw = localthresh(handles.img, str2double(get(hObject, 'string')),...
    str2double(get(handles.edit_msize, 'string')), ...
    get(handles.slider_sthresh, 'value'), get(handles.slider_mthresh, 'value'));
set(handles.imh2, 'CData', handles.bw);
guidata(hObject, handles);


function edit_ssize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_displaylow_Callback(hObject, eventdata, handles)
set(handles.axes1, 'CLim', [str2double(get(hObject, 'string')),...
    str2double(get(handles.edit_displayhigh, 'string'))]);
guidata(hObject, handles);


function edit_displaylow_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_displayhigh_Callback(hObject, eventdata, handles)
set(handles.axes1, 'CLim', [str2double(get(handles.edit_displaylow, 'string')),...
    str2double(get(hObject, 'string'))]);
guidata(hObject, handles);


function edit_displayhigh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function figure1_CloseRequestFcn(hObject, eventdata, handles)
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % Don't kill the figure just yet, but continue on to outputFcn.
    uiresume(hObject);
else
    delete(hObject);
end
