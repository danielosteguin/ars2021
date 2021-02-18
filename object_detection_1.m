clear all; close all; clc;
%% Camera initializing
camList = webcamlist
% device = input('Select your camera device: ')
% cam = webcam(device);
cam = webcam(1);
preview(cam);
% input('Press the enter key to capture the image')
input('Presiona la tecla de Enter para capturar la imagen')
img = snapshot(cam);
clear cam device camList; 
img = img(:,:,1);
img_bin = imbinarize(img);
img_bin = ~img_bin;
se = strel('rectangle',[50 50]);
img_open = imclose(img_bin, se);
img_med = medfilt2(img_open);
stats = regionprops(img_med, 'Area', 'Perimeter');
stats = cell2mat(struct2cell(stats));
area = max(stats(1,:));
perimeter = max(stats(2,:));
sf = perimeter*perimeter/area;
sf = ceil(sf);
if sf >= 1 & sf <14
    text = "It's a circle"
elseif sf >= 15 & sf <19
    text = "It's a square"
else
    text = "It's a triangle" 
end
final = insertText(img,[300 300],text,'FontSize',30);
imshow(final)