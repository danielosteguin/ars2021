%% Reconocimiento de figuras geométricas simples
%El objetivo de este proyecto es realizar una captura fotográfica, adquirir
%la imagen y procesarla para saber que tipo de figura es utilizando el software en MatLab.

%Acosta Avilés Karla Nicol
%Fernández García Daniel Enrique
%Regules Munguía Andrea Hassel

clear; close all; clc;
disp('Reconocimiento de objetos')

%% Primera etapa: obtención de la imagen 
%Si la imagen se toma con matlab
camera=videoinput('winvideo', 1); %Es la cámara que estamos usando 
set(camera, 'ReturnedColorspace', 'rgb') %Establece que la imagen obtenida sea RGB
preview(camera); %Muestra una vista previa de la cámara
pause(5) %Muestra la vista previa por 5 segundos
closepreview(camera); %Cierra la vista previa de la cámara
frame=getsnapshot(camera); %Saca la foto
fname=('FotoObjeto1.jpg'); %Nombre y formato de la foto
imwrite(frame,fname); %Asigna el nombre y el formato

%Si la imagen es propuesta (sacada de archivos)
%frame=imread('FotoObjeto.jpg'); %Lee la imagen y la guarda en la variable imagen

frame=frame(:,:,1); %Convierte la imagen para trabajar con una sola capa
figure, imshow(frame), title ('Imagen para reconocimiento');  %Imprime la imagen obtenida

%% Segunda etapa: suavizado, filtrado e histograma
%Nivel de gris
%figure, imhist(frame), title("Histograma de la imagen original") %Muestra el histograma de la imagen
nivel=graythresh(frame); %Calcula el umbral para la binarización

%% Tercera etapa: procesamiento de la imagen
%Binarizar e invertir
frame=im2bw(frame,nivel); %Binarización de la imagen
%figure, imshow(frame), title("Imagen binarizada") %Muestra la imagen binarizada
frame2=imcomplement(frame); %Invierte los colores de la imagen
%figure,imshow(frame2), title("Imagen invertida") %Muestra la imagen binarizada e invertida

%Filtro
se=strel('rectangle',[50 50]); %Elemento estructurador morfológico
frame3=imclose(frame2, se); %Erosión y dilatación
frame3=medfilt2(frame3); %Suavizado con filtro de mediana

%% Cuarta Etapa: Reconocimiento de imagen. 
%Propiedades: área y perímetro
area=regionprops(frame3,'Area'); %Obtiene el área con el comando regionprops
perimetro=regionprops(frame3,'Perimeter'); %Obtiene el perímetro con el comando regionprops
area=struct2array(area); %Convierte los datos en formato struct a números en un array
perimetro=struct2array(perimetro); %Convierte los datos en formato struct a números en un array
MaxArea=max(area); %Selecciona el área más grande
MaxPerimetro=max(perimetro); %Selecciona el perímetro más grande

%Reconociemiento de figuras
sf=MaxPerimetro*MaxPerimetro/MaxArea; %Compacidad de la geometría
sf=ceil(sf); %Redondeo del valor obtenido
% Clasificación de la figura con base en el resultado de compacidad
if sf >= 1 & sf <14
    text = "Es un círculo"
elseif sf >= 15 & sf <19
    text = "Es un cuadrado"
else
    text = "Es un triángulo"
end
% Muestra del resultado
final = insertText(frame,[300 300],text,'FontSize',30);
imshow(final)