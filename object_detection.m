clear all; close all; clc;
%% Detección de figuras geométricas simples
camList = webcamlist % Lista de dispositivos disponibles
% device = input('Selecciona tu dispositivo: ')
% cam = webcam(device);
cam = webcam(1); % Cámara web a utilzizar
preview(cam); % Vista previa de la cámara
% input('Press the enter key to capture the image')
input('Presiona la tecla de Enter para capturar la imagen') % Espera al usuario
img = snapshot(cam); % Adquisición de imágen
clear cam device camList; 
img = img(:,:,1); % Selecciona una capa de la captura
img_bin = imbinarize(img); % Binarización
img_bin = ~img_bin; % Inversión de la capa
se = strel('rectangle',[50 50]); % Elemento estructurador morfológico
img_open = imclose(img_bin, se); % Erosión y dilatación
img_med = medfilt2(img_open); % Suavizado con filtro de mediana
stats = regionprops(img_med, 'Area', 'Perimeter'); % Cálculo de características de la geometría
stats = cell2mat(struct2cell(stats)); % Conversión de estructura a matriz
area = max(stats(1,:)); % Almacenamiento de valores más grandes del área
perimeter = max(stats(2,:)); % Almacenamiento de valores más grandes del perímetro
sf = perimeter*perimeter/area; % Compacidad de la geometría
sf = ceil(sf); % Redondeo del valor obtenido
% Clasificación de la figura con base en el resultado de compacidad
if sf >= 1 & sf <14
    text = "Es un círculo"
elseif sf >= 15 & sf <19
    text = "Es un cuadrado"
else
    text = "Es un triángulo"
end
% Muestra del resultado
final = insertText(img,[300 300],text,'FontSize',30);
imshow(final)