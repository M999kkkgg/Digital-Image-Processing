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
%显示图片，赋值以及更新;
Nums=0;
flagA=get(handles.SelectA,'Value');
flagB=get(handles.SelectB,'Value');
if(flagA==1.0)
    SrcImgA=img;
    SrcImgNameA=filename;
    axes(handles.axes1)
    imshow(img);
    title('当前打开的图片A');
end
if(flagB==1.0)
    SrcImgB=img;
    SrcImgNameB=filename;
    axes(handles.axes2)
    imshow(img);
    title('当前打开的图片B');
end
if(~isempty(SrcImgA))
    Nums=Nums+1;
end
if(~isempty(SrcImgB))
    Nums=Nums+1;
end
WorkPath=pathname;
%更新
set(handles.Text2,'String',pathname);
string=['图片显示，已打开',num2str(Nums),'张'];
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
    errordlg('没有打开原始图片','Error');
    return;
end
if isempty(MyImg)
    errordlg('没有对原始图片进行处理','Error');
    return;
else
    imwrite(MyImg,fpath,'bmp');%图像文件的写入
end


% --------------------------------------------------------------------
function Save_As_Callback(hObject, eventdata, handles)
% hObject    handle to Save_As (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global Nums;
if (Nums==0)
    errordlg('没有打开原始图片','Error');
    return;
end
if isempty(MyImg)
    errordlg('没有对原始图片进行处理','Error');
    return;
end
[filename, pathname] = uiputfile({'*.bmp','BMP files';'*.jpg;','JPG files';'*.png','PNG files'}, '保存一个图像文件');
if isequal(filename,0) || isequal(pathname,0)
 return;
else
 fpath=fullfile(pathname, filename);
end
imwrite(MyImg,fpath,'bmp');%图像文件的写入


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
    errordlg('没有打开原始图片','Error');
    return;
end
MyImg = rgb2gray(SrcImgA);
axes(handles.axes3)
imshow(MyImg);
title('灰度化处理后')


% --------------------------------------------------------------------
function BW_Callback(hObject, eventdata, handles)
% hObject    handle to BW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
if isempty(SrcImgA)
    errordlg('没有打开原始图片','Error');
    return;
end
MyImg = im2bw(SrcImgA,0.5);
axes(handles.axes3)
imshow(MyImg);
title('二值化处理后')


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
title('测试图像');
flag=get(handles.radiobutton1, 'Value');
if(flag~=0.0)
    [filename, pathname] = uiputfile({'*.bmp','BMP files';'*.jpg;','JPG files';'*.png','PNG files'}, '保存一个图像文件');
    if isequal(filename,0) || isequal(pathname,0)
        return;
    else
        fpath=fullfile(pathname, filename);
    end
    imwrite(MyImg,fpath,'bmp');%图像文件的写入
end
% --------------------------------------------------------------------
function FFT_Callback(hObject, eventdata, handles)
% hObject    handle to FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%计算二维快速博立叶变换
%先转换RGB为灰度图像
[~, n]=size(size(SrcImgA));
if(n==3)
    f=fft2(rgb2gray(SrcImgA));
else
    f=fft2(SrcImgA);
end
axes(handles.axes3);
imshow(f,[]);
title('二维快速博立叶变换')
axes(handles.axes4);
imshow(log(abs(f)+1),[]);
title('二维快速博立叶变换(视觉增强)')
%将变换后的图像频谱中心从矩阵的原点移到矩阵的中心
fc=fftshift(f);
axes(handles.axes5);
imshow(fc,[]);
title('频谱中心从矩阵的原点移到矩阵的中心')
%使用对数变换进行增强
axes(handles.axes6);
imshow(log(abs(fc)+1),[]);
title('频谱中心从矩阵的原点移到矩阵的中心(视觉增强)')
%显示傅里叶变换幅度谱的网格图形
f=abs(fc); 
n=256;
x=1:n;y=1:n; 
axes(handles.axes7);
mesh(x,y,f(x,y)) % mesh 函数用来画三维的网格表面。三维空间中的一个点用(x,y,z)来表示
% --------------------------------------------------------------------
function NoiseContrast_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%添加噪声
NoiseSaltA = imnoise(im2double(SrcImgA), 'salt & pepper', 0.08);
NoiseGausA = imnoise(im2double(SrcImgA), 'gaussian', 0, 0.03);
%显示原始图片与噪声图片
axes(handles.axes4);
imshow(SrcImgA);title('原始图片');
axes(handles.axes5);
imshow(NoiseSaltA);title('椒盐噪声(0.08)');
axes(handles.axes6);
imshow(NoiseGausA);title('高斯噪声(0,0.03)');
%灰度图像的傅里叶变换以及显示
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgAGray=rgb2gray(SrcImgA);
else
    SrcImgAGray=SrcImgA;
end
f=fft2(SrcImgAGray);
fc=fftshift(f);
s=log(abs(fc)+1);%取模并进行缩放
axes(handles.axes7);
subplot(2,2,1);
imshow(SrcImgAGray,[]);title('灰度原图');
subplot(2,2,2);
imshow(s,[]);title('原图频谱');
%椒盐图像的傅里叶变换以及显示
f=fft2(imnoise(SrcImgAGray, 'salt & pepper', 0.08));
fc=fftshift(f);
s=log(abs(fc)+1);%取模并进行缩放
subplot(2,2,3)
imshow(s,[]);title('椒盐频谱');
%高斯图像的傅里叶变换以及显示
f=fft2(imnoise(SrcImgAGray, 'gaussian', 0, 0.03));
fc=fftshift(f);
s=log(abs(fc)+1);%取模并进行缩放
subplot(2,2,4)
imshow(s,[]);title('高斯频谱');


% --------------------------------------------------------------------
function TranslationFFT_Callback(hObject, eventdata, handles)
% hObject    handle to TranslationFFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%生成灰度平移图像组
TestImgA=zeros(256, 256);
TestImgB=zeros(256, 256);
TestImgA(76:180,116:140)=255;
TestImgB(6:110,46:70)=255;
%傅里叶变换
f=fft2(TestImgA);
fc=fftshift(f);
sA=log(abs(fc)+1);%取模并进行缩放
f=fft2(TestImgB);
fc=fftshift(f);
sB=log(abs(fc)+1);%取模并进行缩放
%显示图像
axes(handles.axes1);
imshow(TestImgA);
axes(handles.axes2);
imshow(TestImgB);
axes(handles.axes4);
imshow(sA,[]);title('A的傅里叶变换');
axes(handles.axes5);
imshow(sB,[]);title('B的傅里叶变换');


% --------------------------------------------------------------------
function RotateFFT_Callback(hObject, eventdata, handles)
% hObject    handle to RotateFFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%生成灰度旋转图像组
TestImgA=zeros(256, 256);
TestImgB=zeros(256, 256);
TestImgA(76:180,116:140)=255;
TestImgB(116:140,76:180)=255;
%傅里叶变换
f=fft2(TestImgA);
fc=fftshift(f);
sA=log(abs(fc)+1);%取模并进行缩放
f=fft2(TestImgB);
fc=fftshift(f);
sB=log(abs(fc)+1);%取模并进行缩放
%显示图像
axes(handles.axes1);
imshow(TestImgA);
axes(handles.axes2);
imshow(TestImgB);
axes(handles.axes4);
imshow(sA,[]);title('A的傅里叶变换');
axes(handles.axes5);
imshow(sB,[]);title('B的傅里叶变换');

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
    errordlg('没有打开两张以上的图片','Error');
    return;
end
%获取两图片相加的百分比
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
%检验
[~,nA] = size(size(SrcImgA));
[~,nB] = size(size(SrcImgB));
if nA~=nB
    errordlg('两张图片维度不同','Error');
    return;
end
%设置分辨率一致
[mA, nA, ~] = size(SrcImgA);
TempImgB = imresize(SrcImgB, [mA, nA], 'bilinear');
%if size(SrcImgA)~=size(SrcImgB)
%    errordlg('两张图片分辨率不同','Error');
%    return;
%end
%相加
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
    errordlg('没有打开两张以上的图片','Error');
    return;
end
%检验
[~,nA] = size(size(SrcImgA));
[~,nB] = size(size(SrcImgB));
if nA~=nB
    errordlg('两张图片维度不同','Error');
    return;
end
%设置分辨率一致
[mA, nA, ~] = size(SrcImgA);
TempImgB = imresize(SrcImgB, [mA, nA], 'bilinear');
%相减
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
    errordlg('没有打开原始图片','Error');
    return;
end
%添加噪声
NoiseImgA = imnoise(SrcImgA, 'salt & pepper', 0.1);
axes(handles.axes4);
imshow(SrcImgA);
title('原始图像');
axes(handles.axes5);
imshow(NoiseImgA);
title('噪声图像');
%平均法降噪
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
    errordlg('没有打开原始图片','Error');
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
    errordlg('没有打开原始图片','Error');
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
    errordlg('没有打开原始图片','Error');
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
    errordlg('没有打开原始图片','Error');
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
    errordlg('没有打开原始图片','Error');
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
    errordlg('没有打开原始图片','Error');
    return;
end
MyImg = imnoise(im2double(SrcImgA), 'gaussian');
axes(handles.axes3);
imshow(MyImg);
title('高斯噪声');
% --------------------------------------------------------------------
function Localvar_Callback(hObject, eventdata, handles)
% hObject    handle to Localvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
Asize = size(SrcImgA);
V = zeros(Asize);
V = V + 0.02;
MyImg = imnoise(im2double(SrcImgA), 'localvar', V);
axes(handles.axes3);
imshow(MyImg);
title('0均值高斯白噪声');
% --------------------------------------------------------------------
function Poisson_Callback(hObject, eventdata, handles)
% hObject    handle to Poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
MyImg = imnoise(SrcImgA, 'poisson');
axes(handles.axes3);
imshow(MyImg);
title('泊松噪声');
% --------------------------------------------------------------------
function Salt_Callback(hObject, eventdata, handles)
% hObject    handle to Salt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
MyImg = imnoise(im2double(SrcImgA), 'salt & pepper', 0.08);
axes(handles.axes3);
imshow(MyImg);
title('椒盐噪声');
% --------------------------------------------------------------------
function Speckle_Callback(hObject, eventdata, handles)
% hObject    handle to Speckle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MyImg;
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
MyImg = imnoise(im2double(SrcImgA), 'speckle');
axes(handles.axes3);
imshow(MyImg);
title('乘性噪声');


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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    flag=0;
else
    flag=1;
end
%灰度变换
if(flag==1)
    MyImg=imadjust(SrcImgA,[0.314,0.588],[0,1]);
    axes(handles.axes4);
    imhist(SrcImgA);title('灰度变换前的灰度直方图');
    axes(handles.axes5);
    imhist(MyImg);title('灰度变换后的灰度直方图');
    axes(handles.axes3);
    imshow(MyImg);
    title('灰度增强');
else
    MyImg=imadjust(SrcImgA,[0.2 0.3 0; 0.6 0.7 1],[]);
    axes(handles.axes4);
    imhist(SrcImgA);title('灰度变换前的灰度直方图');
    axes(handles.axes5);
    imhist(MyImg);title('灰度变换后的灰度直方图');
    axes(handles.axes3);
    imshow(MyImg);
    title('灰度增强');
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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
%直方图均衡化
MyImg=histeq(SrcImgA);
axes(handles.axes4);
imhist(SrcImgA);title('均衡化前的灰度直方图');
axes(handles.axes5);
imhist(MyImg);title('均衡化后的灰度直方图');
axes(handles.axes3);
imshow(MyImg);
title('直方图均衡化');

% --------------------------------------------------------------------
function RGBEqualization_Callback(hObject, eventdata, handles)
% hObject    handle to RGBEqualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n~=3)
    errordlg('不是彩色图','Error');
    return;
end
%直方图均衡化
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
title('直方图均衡化');


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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
%算子
H3=fspecial('average',3);
H5=fspecial('average',5);
H9=fspecial('average',9);
%绘制噪声图像
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('椒盐噪声图像');
%邻域平均法降噪
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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
%算子
H3=fspecial('average',3);
H5=fspecial('average',5);
H9=fspecial('average',9);
%绘制噪声图像
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('椒盐噪声图像');
%邻域平均法降噪
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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n~=3)
    errordlg('不是彩色图','Error');
    return;
end
%算子
H3=fspecial('average',3);
H5=fspecial('average',5);
H9=fspecial('average',9);
%绘制噪声图像
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('椒盐噪声图像');
%邻域平均法降噪
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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
%绘制噪声图像
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.03);
axes(handles.axes4);
imshow(ImgAddNoise);    title('椒盐噪声图像');
%中值滤波
MyImg=medfilt2(ImgAddNoise,[5,5]);
axes(handles.axes3);
imshow(uint8(MyImg),[]);   title('中值滤波')


% --------------------------------------------------------------------
function TwoCompare_Callback(hObject, eventdata, handles)
% hObject    handle to TwoCompare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
%绘制噪声图像
ImgAddNoise=imnoise(SrcImgA,'salt & pepper',0.05);
axes(handles.axes4);
imshow(ImgAddNoise);    title('椒盐噪声图像');
%两种滤波的对比
H3=fspecial('average',3);
A=filter2(H3,ImgAddNoise,'same');
B=medfilt2(ImgAddNoise);
axes(handles.axes5);
imshow(uint8(A),[]);   title('邻域平均法');
axes(handles.axes6);
imshow(uint8(B),[]);   title('中值滤波');


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
    errordlg('没有打开原始图片','Error');
    return;
end
%若为RGB则转换为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
noisy=imnoise(SrcImgA,'salt & pepper',0.05);
axes(handles.axes7);
imshow(noisy);
title('噪声图像');
F=fft2(noisy); %傅里叶变换, noisy是添加噪声的图像
F=fftshift(F); %将图像频谱中心从矩阵原点移到矩阵中心
[M,N]=size(F); %求矩阵F的大小
u1=fix(M/2);
u2=fix(N/2);
%获取截止频率
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
        end %理想低通滤波器
        result(u,v)=H*F(u,v);
    end
end
result=ifftshift(result);
J1=ifft2(result);%傅里叶逆变换
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
    errordlg('没有打开原始图片','Error');
    return;
end
%若为RGB则转换为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
% 2阶
n=2;
noisy=imnoise(SrcImgA,'salt & pepper',0.05);
axes(handles.axes7);
imshow(noisy);
title('噪声图像');
F=fft2(noisy); %傅里叶变换, noisy是添加噪声的图像
F=fftshift(F); %将图像频谱中心从矩阵原点移到矩阵中心
[M,N]=size(F); %求矩阵F的大小
u1=fix(M/2);
u2=fix(N/2);
%获取截止频率
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
J1=ifft2(result);%傅里叶逆变换
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
    errordlg('没有打开原始图片','Error');
    return;
end
%若为RGB则转换为灰度图
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
title("边缘提取");
MyImg=Src-TempImg;
axes(handles.axes3);
imshow(uint8(MyImg));
title("拉普拉斯算子")


% --------------------------------------------------------------------
function Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
global MyImg;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%若为RGB则转换为灰度图
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
title("水平边缘提取");
axes(handles.axes5);
imshow(uint8(TempImg2));
title("垂直边缘提取");
Temp=TempImg+TempImg2;
axes(handles.axes6);
imshow(uint8(TempImg2));
title("边缘提取");
MyImg=Src-Temp;
axes(handles.axes3);
imshow(uint8(MyImg));
title("Sobel算子")

% --------------------------------------------------------------------
function Prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to Prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
global MyImg;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%若为RGB则转换为灰度图
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
title("边缘提取");
MyImg=Src-TempImg;
axes(handles.axes3);
imshow(uint8(MyImg));
title("Prewitt算子")


% --------------------------------------------------------------------
function Gradient_Callback(hObject, eventdata, handles)
% hObject    handle to Gradient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%若为RGB则转换为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    SrcImgA=rgb2gray(SrcImgA);
    axes(handles.axes1);
    imshow(SrcImgA);
end
Src=double(SrcImgA);
[Gx,Gy]=gradient(Src);
G=sqrt(Gx.*Gx+Gy.*Gy);
%第一种
J1=G;
% 第二种
J2=Src;
K=find(G>=7);
J2(K)=G(K);
% 第三种图像增强
J3=Src;
K=find(G>=7);
J3(K)=255;
% 第四种图像增强
J4=Src;
K=find(G<=7);
J4(K)=255;
% 第五种图像增强
J5=Src;
K=find(G<=7);
J5(K)=0;
Q=find(G>=7);
J5(Q)=255;
%显示
axes(handles.axes2);
imshow(uint8(J1));
title("第一种");
axes(handles.axes3);
imshow(uint8(J2));
title("第二种");
axes(handles.axes4);
imshow(uint8(J3));
title("第三种");
axes(handles.axes5);
imshow(uint8(J4));
title("第四种");
axes(handles.axes6);
imshow(uint8(J5));
title("第五种");



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
    errordlg('没有打开原始图片','Error');
    return;
end
%ImgA=double(SrcImgA);
ImgA=SrcImgA;
LEN=30; %设置运动位移为30个像素
THETA=75; %设置运动角度为75度
PSF=fspecial('motion',LEN,THETA); 
%建立二维仿真线性运动滤波器PSF
MF=imfilter(ImgA,PSF,'circular','conv'); %用PSF产生退化图像
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
    errordlg('没有打开原始图片','Error');
    return;
end
LEN=30;     %设置运动位移为30个像素
THETA=75;   %设置运动角度为75度
PSF=fspecial('motion',LEN,THETA);   %建立二维仿真线性运动滤波器PSF
wnr1=deconvwnr(SrcImgA,PSF);     %用Wiener滤波消除运动模糊的图像
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
    errordlg('没有打开原始图片','Error');
    return;
end
Img=double(SrcImgA);
LEN=20;
THETA=45;
PSF=fspecial('motion',LEN,THETA);   %建立二维仿真线性运动滤波器PSF
MF=imfilter(Img,PSF,'circular','conv'); %用PSF产生退化图像
axes(handles.axes4);
imshow(uint8(MF)); title('运动退化图像')
wnr1=deconvwnr(MF,PSF);     %用Wiener滤波消除运动模糊的图像
axes(handles.axes5);
imshow(uint8(wnr1)); title('图像复原后')


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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
axes(handles.axes7);
imhist(SrcImgA);
title('灰度直方图');

% --------------------------------------------------------------------
function ThresholdSeparation_Callback(hObject, eventdata, handles)
% hObject    handle to ThresholdSeparation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global MyImg;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
% 获取阈值分子
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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
level = graythresh(SrcImgA);
MyImg = im2bw(SrcImgA,level);
axes(handles.axes3);
imshow(MyImg);
title('Otsu获得阈值');


% --------------------------------------------------------------------
function EdgeDetection_Callback(hObject, eventdata, handles)
% hObject    handle to EdgeDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SrcImgA;
global Nums;
if isempty(SrcImgA)||Nums==0
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为灰度图
[~, n]=size(size(SrcImgA));
if(n==3)
    errordlg('不是灰度图','Error');
    return;
end
% Sobel
axes(handles.axes2);
SobelImg=edge(SrcImgA,'sobel',0.1);
imshow(SobelImg);   title('Sobel算子')
% Roberts
axes(handles.axes3);
RobertsImg=edge(SrcImgA,'roberts',0.1);
imshow(RobertsImg);   title('Roberts算子')
% Prewitt
axes(handles.axes4);
PrewittImg=edge(SrcImgA,'prewitt',0.1);
imshow(PrewittImg);   title('Prewitt算子')
% Log
axes(handles.axes5);
LogImg=edge(SrcImgA,'log',0.01);
imshow(LogImg);   title('Log算子')
% Canny
axes(handles.axes6);
CannyImg=edge(SrcImgA,'canny',0.1);
imshow(CannyImg);   title('Canny算子')


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
    errordlg('没有打开原始图片','Error');
    return;
end
%先判断是否为彩色图
[~, n]=size(size(SrcImgA));
if(n~=3)
    errordlg('不是灰度图','Error');
    return;
end
[m,n,d]=size(SrcImgA);
R=SrcImgA(:,:,1);%提取红色分量 
G=SrcImgA(:,:,2);%提取绿色分量 
B=SrcImgA(:,:,3);%提取蓝色分量 
axes(handles.axes4);
imshow(R);  title('红色通道');
axes(handles.axes5);
imshow(G);  title('绿色通道');
axes(handles.axes6);
imshow(B);  title('蓝色通道');
% 区域生长函数
% 运行时会产生一个figure
% 鼠标选取种子位置后，按回车确定
% 返回一个区域生长处理后的灰度图像
% 测试后发现红色分量最明显，所以对红色分量分割
ImgR = Growing(R);
MyImg =SrcImgA;
% 对分割后的红色分量遍历
% 对于设置为灰度值的点
% 对应的RGB图像位置设置为白色
for i=1:m
    for j=1:n
        if(ImgR(i,j)~=0)
           MyImg(i,j,1)=255;
           MyImg(i,j,2)=255; 
           MyImg(i,j,3)=255; 
        end
    end
end
% 可行改进方案
% 结合三通道分别处理可能会有更好的效果
% 2020.12.31 马树凡
axes(handles.axes3);
imshow(MyImg);  title('分割结果');
