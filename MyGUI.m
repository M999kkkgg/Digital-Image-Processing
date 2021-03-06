function varargout = MyGUI(varargin)
% MYGUI MATLAB code for MyGUI.fig
%      MYGUI, by itself, creates a new MYGUI or raises the existing
%      singleton*.
%
%      H = MYGUI returns the handle to a new MYGUI or the handle to
%      the existing singleton*.
%
%      MYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUI.M with the given input arguments.
%
%      MYGUI('Property','Value',...) creates a new MYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyGUI

% Last Modified by GUIDE v2.5 31-Dec-2020 08:18:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MyGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
% Global Values
global SrcImgA;
global SrcImgB;
global SrcImgNmaeA;
global SrcImgNameB;
global MyImg;
global WorkPath;
global Nums;
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MyGUI is made visible.
function MyGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyGUI (see VARARGIN)
global Nums;
global SrcImgA;
global SrcImgB;
SrcImgA=[];
SrcImgB=[];
Nums=0;
% Choose default command line output for MyGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MyGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MyGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Files_Callback(hObject, eventdata, handles)
% hObject    handle to Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Type_Conversion_Callback(hObject, eventdata, handles)
% hObject    handle to Type_Conversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global SrcImgB;
global SrcImgNameA;
global SrcImgNameB;
global WorkPath;
global Nums;
[filename,pathname]=uigetfile('*.bmp','Open a bmp file');
datafile=[pathname,filename];
img=imread(datafile);
%??????????????????????;
Nums=0;
flagA=get(handles.SelectA,'Value');
flagB=get(handles.SelectB,'Value');
if(flagA==1.0)
    SrcImgA=img;
    SrcImgNameA=filename;
    axes(handles.axes1)
    imshow(img);
    title('??????????????A');
end
if(flagB==1.0)
    SrcImgB=img;
    SrcImgNameB=filename;
    axes(handles.axes2)
    imshow(img);
    title('??????????????B');
end
if(~isempty(SrcImgA))
    Nums=Nums+1;
end
if(~isempty(SrcImgB))
    Nums=Nums+1;
end
WorkPath=pathname;
%????
set(handles.Text2,'String',pathname);
string=['????????????????',num2str(Nums),'??'];
set(handles.uipanel1,'Title',string);



% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WorkPath;
global MyImg;
global Nums;
global SrcImgNameA;
fpath=fullfile(WorkPath, SrcImgNameA);
if (Nums==0)
    errordlg('????????????????','Error');
    return;
end
if isempty(MyImg)
    errordlg('??????????????????????','Error');
    return;
else
    imwrite(MyImg,fpath,'bmp');%??????????????
end


% --------------------------------------------------------------------
function Save_As_Callback(hObject, eventdata, handles)
% hObject    handle to Save_As (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global Nums;
if (Nums==0)
    errordlg('????????????????','Error');
    return;
end
if isempty(MyImg)
    errordlg('??????????????????????','Error');
    return;
end
[filename, pathname] = uiputfile({'*.bmp','BMP files';'*.jpg;','JPG files';'*.png','PNG files'}, '????????????????');
if isequal(filename,0) || isequal(pathname,0)
 return;
else
 fpath=fullfile(pathname, filename);
end
imwrite(MyImg,fpath,'bmp');%??????????????


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close (MyGUI);


% --------------------------------------------------------------------
function RGB2GRAY_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2GRAY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
if isempty(SrcImgA)
    errordlg('????????????????','Error');
    return;
end
MyImg = rgb2gray(SrcImgA);
axes(handles.axes3)
imshow(MyImg);
title('????????????')


% --------------------------------------------------------------------
function BW_Callback(hObject, eventdata, handles)
% hObject    handle to BW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
if isempty(SrcImgA)
    errordlg('????????????????','Error');
    return;
end
MyImg = im2bw(SrcImgA,0.5);
axes(handles.axes3)
imshow(MyImg);
title('????????????')


% --------------------------------------------------------------------
function Operation_Callback(hObject, eventdata, handles)
% hObject    handle to Operation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Fourier_Callback(hObject, eventdata, handles)
% hObject    handle to Fourier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function MakeImg_Callback(hObject, eventdata, handles)
% hObject    handle to MakeImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
TestImg=zeros(256, 256);
%TestImg(76:180,76:180)=255;
%TestImg(76:180,116:140)=255;
%TestImg(110:144,110:144)=255;
TestImg(120:134,120:134)=255;
%TestImg(116:140,76:180)=255;
MyImg=TestImg;
axes(handles.axes3);
imshow(MyImg);
title('????????');
flag=get(handles.radiobutton1, 'Value');
if(flag~=0.0)
    [filename, pathname] = uiputfile({'*.bmp','BMP files';'*.jpg;','JPG files';'*.png','PNG files'}, '????????????????');
    if isequal(filename,0) || isequal(pathname,0)
        return;
    else
        fpath=fullfile(pathname, filename);
    end
    imwrite(MyImg,fpath,'bmp');%??????????????
end
% --------------------------------------------------------------------
function FFT_Callback(hObject, eventdata, handles)
% hObject    handle to FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????????
%??????RGB??????????
[~, n]=size(size(SrcImgA));
if(n==3)
    f=fft2(rgb2gray(SrcImgA));
else
    f=fft2(SrcImgA);
end
axes(handles.axes3);
imshow(f,[]);
title('??????????????????')
axes(handles.axes4);
imshow(log(abs(f)+1),[]);
title('??????????????????(????????)')
%????????????????????????????????????????????????
fc=fftshift(f);
axes(handles.axes5);
imshow(fc,[]);
title('??????????????????????????????????')
%????????????????????
axes(handles.axes6);
imshow(log(abs(fc)+1),[]);
title('??????????????????????????????????(????????)')
%??????????????????????????????
f=abs(fc); 
n=256;
x=1:n;y=1:n; 
axes(handles.axes7);
mesh(x,y,f(x,y)) % mesh ??????????????????????????????????????????????(x,y,z)??????
% --------------------------------------------------------------------
function NoiseContrast_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????????
NoiseSaltA = imnoise(im2double(SrcImgA), 'salt & pepper', 0.08);
NoiseGausA = imnoise(im2double(SrcImgA), 'gaussian', 0, 0.03);
%??????????????????????
axes(handles.axes4);
imshow(SrcImgA);title('????????');
axes(handles.axes5);
imshow(NoiseSaltA);title('????????(0.08)');
axes(handles.axes6);
imshow(NoiseGausA);title('????????(0,0.03)');
%????????????????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgAGray=rgb2gray(SrcImgA);
else
    SrcImgAGray=SrcImgA;
end
f=fft2(SrcImgAGray);
fc=fftshift(f);
s=log(abs(fc)+1);%??????????????
axes(handles.axes7);
subplot(2,2,1);
imshow(SrcImgAGray,[]);title('????????');
subplot(2,2,2);
imshow(s,[]);title('????????');
%????????????????????????????
f=fft2(imnoise(SrcImgAGray, 'salt & pepper', 0.08));
fc=fftshift(f);
s=log(abs(fc)+1);%??????????????
subplot(2,2,3)
imshow(s,[]);title('????????');
%????????????????????????????
f=fft2(imnoise(SrcImgAGray, 'gaussian', 0, 0.03));
fc=fftshift(f);
s=log(abs(fc)+1);%??????????????
subplot(2,2,4)
imshow(s,[]);title('????????');


% --------------------------------------------------------------------
function TranslationFFT_Callback(hObject, eventdata, handles)
% hObject    handle to TranslationFFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%??????????????????
TestImgA=zeros(256, 256);
TestImgB=zeros(256, 256);
TestImgA(76:180,116:140)=255;
TestImgB(6:110,46:70)=255;
%??????????
f=fft2(TestImgA);
fc=fftshift(f);
sA=log(abs(fc)+1);%??????????????
f=fft2(TestImgB);
fc=fftshift(f);
sB=log(abs(fc)+1);%??????????????
%????????
axes(handles.axes1);
imshow(TestImgA);
axes(handles.axes2);
imshow(TestImgB);
axes(handles.axes4);
imshow(sA,[]);title('A????????????');
axes(handles.axes5);
imshow(sB,[]);title('B????????????');


% --------------------------------------------------------------------
function RotateFFT_Callback(hObject, eventdata, handles)
% hObject    handle to RotateFFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%??????????????????
TestImgA=zeros(256, 256);
TestImgB=zeros(256, 256);
TestImgA(76:180,116:140)=255;
TestImgB(116:140,76:180)=255;
%??????????
f=fft2(TestImgA);
fc=fftshift(f);
sA=log(abs(fc)+1);%??????????????
f=fft2(TestImgB);
fc=fftshift(f);
sB=log(abs(fc)+1);%??????????????
%????????
axes(handles.axes1);
imshow(TestImgA);
axes(handles.axes2);
imshow(TestImgB);
axes(handles.axes4);
imshow(sA,[]);title('A????????????');
axes(handles.axes5);
imshow(sB,[]);title('B????????????');

% --------------------------------------------------------------------
function Algebra_Callback(hObject, eventdata, handles)
% hObject    handle to Algebra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Add_Callback(hObject, eventdata, handles)
% hObject    handle to Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global SrcImgB;
global Nums;
if isempty(SrcImgA)||isempty(SrcImgB)||Nums~=2
    errordlg('??????????????????????','Error');
    return;
end
%??????????????????????
A = get(handles.edit5, 'String');
A = str2double(A);
if A>1.0
    A=1.0;
end
if A<0.0
    A=0.0;
end
B = get(handles.edit6, 'String');
B = str2double(B);
if B>1.0
    B=1.0;
end
if B<0.0
    B=0.0;
end
%????
[~,nA] = size(size(SrcImgA));
[~,nB] = size(size(SrcImgB));
if nA~=nB
    errordlg('????????????????','Error');
    return;
end
%??????????????
[mA, nA, ~] = size(SrcImgA);
TempImgB = imresize(SrcImgB, [mA, nA], 'bilinear');
%if size(SrcImgA)~=size(SrcImgB)
%    errordlg('??????????????????','Error');
%    return;
%end
%????
MyImg = imlincomb(A,SrcImgA,B,TempImgB);
axes(handles.axes3);
imshow(MyImg);
% --------------------------------------------------------------------
function Sub_Callback(hObject, eventdata, handles)
% hObject    handle to Sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global SrcImgB;
global Nums;
if isempty(SrcImgA)||isempty(SrcImgB)||Nums~=2
    errordlg('??????????????????????','Error');
    return;
end
%????
[~,nA] = size(size(SrcImgA));
[~,nB] = size(size(SrcImgB));
if nA~=nB
    errordlg('????????????????','Error');
    return;
end
%??????????????
[mA, nA, ~] = size(SrcImgA);
TempImgB = imresize(SrcImgB, [mA, nA], 'bilinear');
%????
MyImg = imsubtract(SrcImgA,TempImgB);
axes(handles.axes3);
imshow(MyImg);
% --------------------------------------------------------------------
function AVENoise_Callback(hObject, eventdata, handles)
% hObject    handle to AVENoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????????
NoiseImgA = imnoise(SrcImgA, 'salt & pepper', 0.1);
axes(handles.axes4);
imshow(SrcImgA);
title('????????');
axes(handles.axes5);
imshow(NoiseImgA);
title('????????');
%??????????
M = get(handles.edit7, 'String');
M = floor(str2double(M));
TempImg = imlincomb(0.5, SrcImgA, 0.5, NoiseImgA);
for i=1:(M-1)
    TempImg = imlincomb(0.5, TempImg, 0.5, SrcImgA);
end
MyImg = TempImg;
axes(handles.axes3);
imshow(MyImg);


% --------------------------------------------------------------------
function Geometric_Callback(hObject, eventdata, handles)
% hObject    handle to Geometric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Zoom_Callback(hObject, eventdata, handles)
% hObject    handle to Zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
size = get(handles.edit1, 'String');
size = str2double(size);
MyImg = imresize(SrcImgA, size, 'nearest');
axes(handles.axes3);
imshow(MyImg);
% --------------------------------------------------------------------
function Ratate_Callback(hObject, eventdata, handles)
% hObject    handle to Ratate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
degree = get(handles.edit2, 'String');
degree = str2double(degree);
MyImg = imrotate(SrcImgA, degree, 'bilinear', 'crop');
axes(handles.axes3);
imshow(MyImg);
% --------------------------------------------------------------------
function MirrorVERT_Callback(hObject, eventdata, handles)
% hObject    handle to MirrorVERT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
MyImg = flipdim(SrcImgA, 1);
axes(handles.axes3);
imshow(MyImg);
% --------------------------------------------------------------------
function MirrorHOR_Callback(hObject, eventdata, handles)
% hObject    handle to MirrorHOR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
MyImg = flipdim(SrcImgA, 2);
axes(handles.axes3);
imshow(MyImg);
% --------------------------------------------------------------------
function Reverse_Callback(hObject, eventdata, handles)
% hObject    handle to Reverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
MyImg = imcomplement(SrcImgA);
axes(handles.axes3);
imshow(MyImg);


% --------------------------------------------------------------------
function AddNoise_Callback(hObject, eventdata, handles)
% hObject    handle to AddNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function Gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to Gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
MyImg = imnoise(im2double(SrcImgA), 'gaussian');
axes(handles.axes3);
imshow(MyImg);
title('????????');
% --------------------------------------------------------------------
function Localvar_Callback(hObject, eventdata, handles)
% hObject    handle to Localvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
Asize = size(SrcImgA);
V = zeros(Asize);
V = V + 0.02;
MyImg = imnoise(im2double(SrcImgA), 'localvar', V);
axes(handles.axes3);
imshow(MyImg);
title('0??????????????');
% --------------------------------------------------------------------
function Poisson_Callback(hObject, eventdata, handles)
% hObject    handle to Poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
MyImg = imnoise(SrcImgA, 'poisson');
axes(handles.axes3);
imshow(MyImg);
title('????????');
% --------------------------------------------------------------------
function Salt_Callback(hObject, eventdata, handles)
% hObject    handle to Salt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
MyImg = imnoise(im2double(SrcImgA), 'salt & pepper', 0.08);
axes(handles.axes3);
imshow(MyImg);
title('????????');
% --------------------------------------------------------------------
function Speckle_Callback(hObject, eventdata, handles)
% hObject    handle to Speckle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
MyImg = imnoise(im2double(SrcImgA), 'speckle');
axes(handles.axes3);
imshow(MyImg);
title('????????');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --------------------------------------------------------------------
function ImageEnhance_Callback(hObject, eventdata, handles)
% hObject    handle to ImageEnhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function GrayScaleTransformation_Callback(hObject, eventdata, handles)
% hObject    handle to GrayScaleTransformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
flag=0;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    flag=0;
else
    flag=1;
end
%????????
if(flag==1)
    MyImg=imadjust(SrcImgA,[0.314,0.588],[0,1]);
    axes(handles.axes4);
    imhist(SrcImgA);title('??????????????????????');
    axes(handles.axes5);
    imhist(MyImg);title('??????????????????????');
    axes(handles.axes3);
    imshow(MyImg);
    title('????????');
else
    MyImg=imadjust(SrcImgA,[0.2 0.3 0; 0.6 0.7 1],[]);
    axes(handles.axes4);
    imhist(SrcImgA);title('??????????????????????');
    axes(handles.axes5);
    imhist(MyImg);title('??????????????????????');
    axes(handles.axes3);
    imshow(MyImg);
    title('????????');
end


% --------------------------------------------------------------------
function HistEqualization_Callback(hObject, eventdata, handles)
% hObject    handle to HistEqualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
%????????????
MyImg=histeq(SrcImgA);
axes(handles.axes4);
imhist(SrcImgA);title('????????????????????');
axes(handles.axes5);
imhist(MyImg);title('????????????????????');
axes(handles.axes3);
imshow(MyImg);
title('????????????');

% --------------------------------------------------------------------
function RGBEqualization_Callback(hObject, eventdata, handles)
% hObject    handle to RGBEqualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n~=3)
    errordlg('??????????','Error');
    return;
end
%????????????
R=SrcImgA(:,:,1);
G=SrcImgA(:,:,2);
B=SrcImgA(:,:,3);
R1=histeq(R);
G1=histeq(G);
B1=histeq(B);
MyImg=cat(3,R1,G1,B1);
axes(handles.axes4);
imhist(R1); title('R');
axes(handles.axes5);
imhist(G1); title('G');
axes(handles.axes6);
imhist(B1);  title('B')
axes(handles.axes3);
imshow(MyImg);
title('????????????');


% --- Executes on button press in SelectA.
function SelectA_Callback(hObject, eventdata, handles)
% hObject    handle to SelectA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectA


% --- Executes on button press in SelectB.
function SelectB_Callback(hObject, eventdata, handles)
% hObject    handle to SelectB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SelectB


% --------------------------------------------------------------------
function NeighborhoodAverageMethod_Callback(hObject, eventdata, handles)
% hObject    handle to NeighborhoodAverageMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function isGrayFILTER_Callback(hObject, eventdata, handles)
% hObject    handle to isGrayFILTER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
%????
H3=fspecial('average',3);
H5=fspecial('average',5);
H9=fspecial('average',9);
%????????????
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('????????????');
%??????????????
M3=filter2(H3,ImgAddNoise,'full');
M5=filter2(H5,ImgAddNoise,'full');
M9=filter2(H9,ImgAddNoise,'full');
MyImg=M3;
axes(handles.axes3);
imshow(uint8(MyImg),[]);     title('3*3');
axes(handles.axes5);
imshow(uint8(M5),[]);     title('5*5');
axes(handles.axes6);
imshow(uint8(M9),[]);  title('9*9');


% --------------------------------------------------------------------
function isGrayCONV_Callback(hObject, eventdata, handles)
% hObject    handle to isGrayCONV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
%????
H3=fspecial('average',3);
H5=fspecial('average',5);
H9=fspecial('average',9);
%????????????
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('????????????');
%??????????????
M3=conv2(ImgAddNoise,H3,'full');
M5=conv2(ImgAddNoise,H5,'full');
M9=conv2(ImgAddNoise,H9,'full');
MyImg=M3;
axes(handles.axes3);
imshow(uint8(MyImg),[]);     title('3*3');
axes(handles.axes5);
imshow(uint8(M5),[]);     title('5*5');
axes(handles.axes6);
imshow(uint8(M9),[]);  title('9*9');


function isRGB_Callback(hObject, eventdata, handles)
% hObject    handle to isGrayCONV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n~=3)
    errordlg('??????????','Error');
    return;
end
%????
H3=fspecial('average',3);
H5=fspecial('average',5);
H9=fspecial('average',9);
%????????????
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('????????????');
%??????????????
M3=imfilter(ImgAddNoise,H3);
M5=imfilter(ImgAddNoise,H5);
M9=imfilter(ImgAddNoise,H9);
MyImg=M3;
axes(handles.axes3);
imshow(uint8(MyImg),[]);     title('3*3');
axes(handles.axes5);
imshow(uint8(M5),[]);     title('5*5');
axes(handles.axes6);
imshow(uint8(M9),[]);  title('9*9');


% --------------------------------------------------------------------
function MedianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to MedianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
%????????????
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('????????????');
%????????
MyImg=medfilt2(ImgAddNoise,[5,5]);
axes(handles.axes3);
imshow(uint8(MyImg),[]);   title('????????')


% --------------------------------------------------------------------
function TwoCompare_Callback(hObject, eventdata, handles)
% hObject    handle to TwoCompare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
%????????????
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.05);
axes(handles.axes4);
imshow(ImgAddNoise);    title('????????????');
%??????????????
H3=fspecial('average',3);
A=filter2(H3,ImgAddNoise,'same');
B=medfilt2(ImgAddNoise);
axes(handles.axes5);
imshow(uint8(A),[]);   title('??????????');
axes(handles.axes6);
imshow(uint8(B),[]);   title('????????');


% --------------------------------------------------------------------
function Other_Callback(hObject, eventdata, handles)
% hObject    handle to Other (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img=[1,2,2,2,3;
    1,15,1,2,2;
    2,1,2,0,3;
    0,2,2,3,1;
    3,2,0,2,2]
axes(handles.axes4);
imshow(Img);
H3=ones(3,3)/9;
A=conv2(Img,H3,'full');
uint8(A)
axes(handles.axes5);
imshow(uint8(A),[]);


% --------------------------------------------------------------------
function Sharpening_Callback(hObject, eventdata, handles)
% hObject    handle to Sharpening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Smoothing_Callback(hObject, eventdata, handles)
% hObject    handle to Smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Ideal_Callback(hObject, eventdata, handles)
% hObject    handle to Ideal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????RGB??????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
noisy=imnoise(SrcImgA,'salt & pepper',0.05);
axes(handles.axes7);
imshow(noisy);
title('????????');
F=fft2(noisy); %??????????, noisy????????????????
F=fftshift(F); %????????????????????????????????????
[M,N]=size(F); %??????F??????
u1=fix(M/2);
u2=fix(N/2);
%????????????
D0 = get(handles.editP, 'String');
D0 = str2double(D0);
if(D0>200)
    D0=200;
    set(handles.editP,'String','200');
end
if(D0<10)
    D0=10;
    set(handles.editP,'String','10');
end
for u=1:M
    for v=1:N
        D=sqrt((u-u1)^2+(v-u2)^2);
        if (D<=D0) 
            H=1;
        else
            H=0;
        end %??????????????
        result(u,v)=H*F(u,v);
    end
end
result=ifftshift(result);
J1=ifft2(result);%????????????
J2=uint8(real(J1));
axes(handles.axes3)
imshow(J2);
title(D0);


% --------------------------------------------------------------------
function ButterworthLow_Callback(hObject, eventdata, handles)
% hObject    handle to ButterworthLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????RGB??????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
% 2??
n=2;
noisy=imnoise(SrcImgA,'salt & pepper',0.05);
axes(handles.axes7);
imshow(noisy);
title('????????');
F=fft2(noisy); %??????????, noisy????????????????
F=fftshift(F); %????????????????????????????????????
[M,N]=size(F); %??????F??????
u1=fix(M/2);
u2=fix(N/2);
%????????????
D0 = get(handles.editP, 'String');
D0 = str2double(D0);
if(D0>200)
    D0=200;
    set(handles.editP,'String','200');
end
if(D0<10)
    D0=10;
    set(handles.editP,'String','10');
end
for u=1:M
    for v=1:N
        D=sqrt((u-u1)^2+(v-u2)^2);
        H=1/(1+(D/D0)^(2*n));
        result(u,v)=H*F(u,v);
    end
end
result=ifftshift(result);
J1=ifft2(result);%????????????
J2=uint8(real(J1));
axes(handles.axes3)
imshow(J2);
title(D0);


% --------------------------------------------------------------------
function Laplace_Callback(hObject, eventdata, handles)
% hObject    handle to Laplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????RGB??????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
H=[0,1,0;1,-4,1;0,1,0];
Src=double(SrcImgA);
TempImg=conv2(Src,H,'same');
axes(handles.axes6);
imshow(uint8(TempImg));
title("????????");
MyImg=Src-TempImg;
axes(handles.axes3);
imshow(uint8(MyImg));
title("????????????")


% --------------------------------------------------------------------
function Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
global MyImg;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????RGB??????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
H=fspecial('sobel');
H2=[1,0,-1;2,0,-2;1,0,-1];
Src=double(SrcImgA);
TempImg=conv2(Src,H,'same');
TempImg2=conv2(Src,H2,'same');
axes(handles.axes4);
imshow(uint8(TempImg));
title("????????????");
axes(handles.axes5);
imshow(uint8(TempImg2));
title("????????????");
Temp=TempImg+TempImg2;
axes(handles.axes6);
imshow(uint8(TempImg2));
title("????????");
MyImg=Src-Temp;
axes(handles.axes3);
imshow(uint8(MyImg));
title("Sobel????")

% --------------------------------------------------------------------
function Prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to Prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
global MyImg;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????RGB??????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
H=fspecial('prewitt');
Src=double(SrcImgA);
TempImg=conv2(Src,H,'same');
axes(handles.axes6);
imshow(uint8(TempImg));
title("????????");
MyImg=Src-TempImg;
axes(handles.axes3);
imshow(uint8(MyImg));
title("Prewitt????")


% --------------------------------------------------------------------
function Gradient_Callback(hObject, eventdata, handles)
% hObject    handle to Gradient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%????RGB??????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
Src=double(SrcImgA);
[Gx,Gy]=gradient(Src);
G=sqrt(Gx.*Gx+Gy.*Gy);
%??????
J1=G;
% ??????
J2=Src;
K=find(G>=7);
J2(K)=G(K);
% ??????????????
J3=Src;
K=find(G>=7);
J3(K)=255;
% ??????????????
J4=Src;
K=find(G<=7);
J4(K)=255;
% ??????????????
J5=Src;
K=find(G<=7);
J5(K)=0;
Q=find(G>=7);
J5(Q)=255;
%????
axes(handles.axes2);
imshow(uint8(J1));
title("??????");
axes(handles.axes3);
imshow(uint8(J2));
title("??????");
axes(handles.axes4);
imshow(uint8(J3));
title("??????");
axes(handles.axes5);
imshow(uint8(J4));
title("??????");
axes(handles.axes6);
imshow(uint8(J5));
title("??????");



function editP_Callback(hObject, eventdata, handles)
% hObject    handle to editP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editP as text
%        str2double(get(hObject,'String')) returns contents of editP as a double


% --- Executes during object creation, after setting all properties.
function editP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function ImageRestoration_Callback(hObject, eventdata, handles)
% hObject    handle to ImageRestoration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Degeneration_Callback(hObject, eventdata, handles)
% hObject    handle to Degeneration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%ImgA=double(SrcImgA);
ImgA=SrcImgA;
LEN=30; %??????????????30??????
THETA=75; %??????????????75??
PSF=fspecial('motion',LEN,THETA); 
%??????????????????????????PSF
MF=imfilter(ImgA,PSF,'circular','conv'); %??PSF????????????
MyImg=MF;
axes(handles.axes3);
imshow(MyImg);

% --------------------------------------------------------------------
function Wiener_Callback(hObject, eventdata, handles)
% hObject    handle to Wiener (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
LEN=30;     %??????????????30??????
THETA=75;   %??????????????75??
PSF=fspecial('motion',LEN,THETA);   %??????????????????????????PSF
wnr1=deconvwnr(SrcImgA,PSF);     %??Wiener??????????????????????
MyImg=wnr1;
axes(handles.axes3);
imshow(MyImg);

% --------------------------------------------------------------------
function RestorationTest_Callback(hObject, eventdata, handles)
% hObject    handle to RestorationTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
Img=double(SrcImgA);
LEN=20;
THETA=45;
PSF=fspecial('motion',LEN,THETA);   %??????????????????????????PSF
MF=imfilter(Img,PSF,'circular','conv'); %??PSF????????????
axes(handles.axes4);
imshow(uint8(MF)); title('????????????')
wnr1=deconvwnr(MF,PSF);     %??Wiener??????????????????????
axes(handles.axes5);
imshow(uint8(wnr1)); title('??????????')


% --------------------------------------------------------------------
function ImageSeparation_Callback(hObject, eventdata, handles)
% hObject    handle to ImageSeparation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function HistogramThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to HistogramThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ShowHist_Callback(hObject, eventdata, handles)
% hObject    handle to ShowHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
axes(handles.axes7);
imhist(SrcImgA);
title('??????????');

% --------------------------------------------------------------------
function ThresholdSeparation_Callback(hObject, eventdata, handles)
% hObject    handle to ThresholdSeparation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
% ????????????
x = get(handles.edit14, 'String');
x = str2double(x);
if x<0
    x=0;
end
if x>255
    x=255;
end
threshold=x/255;
MyImg=im2bw(SrcImgA,threshold);
axes(handles.axes3);
imshow(MyImg);


% --------------------------------------------------------------------
function Otsu_Callback(hObject, eventdata, handles)
% hObject    handle to Otsu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
level = graythresh(SrcImgA);
MyImg = im2bw(SrcImgA,level);
axes(handles.axes3);
imshow(MyImg);
title('Otsu????????');


% --------------------------------------------------------------------
function EdgeDetection_Callback(hObject, eventdata, handles)
% hObject    handle to EdgeDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('??????????','Error');
    return;
end
% Sobel
axes(handles.axes2);
SobelImg=edge(SrcImgA,'sobel',0.1);
imshow(SobelImg);   title('Sobel????')
% Roberts
axes(handles.axes3);
RobertsImg=edge(SrcImgA,'roberts',0.1);
imshow(RobertsImg);   title('Roberts????')
% Prewitt
axes(handles.axes4);
PrewittImg=edge(SrcImgA,'prewitt',0.1);
imshow(PrewittImg);   title('Prewitt????')
% Log
axes(handles.axes5);
LogImg=edge(SrcImgA,'log',0.01);
imshow(LogImg);   title('Log????')
% Canny
axes(handles.axes6);
CannyImg=edge(SrcImgA,'canny',0.1);
imshow(CannyImg);   title('Canny????')


function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function leaf_Callback(hObject, eventdata, handles)
% hObject    handle to leaf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('????????????????','Error');
    return;
end
%??????????????????
[~, n]=size(size(SrcImgA));
if(n~=3)
    errordlg('??????????','Error');
    return;
end
[m,n,d]=size(SrcImgA);
R=SrcImgA(:,:,1);%???????????? 
G=SrcImgA(:,:,2);%???????????? 
B=SrcImgA(:,:,3);%???????????? 
axes(handles.axes4);
imshow(R);  title('????????');
axes(handles.axes5);
imshow(G);  title('????????');
axes(handles.axes6);
imshow(B);  title('????????');
% ????????????
% ????????????????figure
% ??????????????????????????????
% ????????????????????????????????
% ????????????????????????????????????????????
ImgR = Growing(R);
MyImg =SrcImgA;
% ??????????????????????
% ????????????????????
% ??????RGB??????????????????
for i=1:m
    for j=1:n
        if(ImgR(i,j)~=0)
           MyImg(i,j,1)=255;
           MyImg(i,j,2)=255; 
           MyImg(i,j,3)=255; 
        end
    end
end
% ????????????
% ????????????????????????????????????
% 2020.12.31 ??????
axes(handles.axes3);
imshow(MyImg);  title('????????');
