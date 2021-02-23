%% Reconocimiento de figuras geom�tricas simples
%El objetivo de este proyecto es realizar una captura fotogr�fica, adquirir
%la imagen y procesarla para saber que tipo de figura es utilizando el software en MatLab.

%Acosta Avil�s Karla Nicol
%Fern�ndez Garc�a Daniel Enrique
%Regules Mungu�a Andrea Hassel

clear; close all; clc;
disp('Reconocimiento de objetos')

%% Primera etapa: obtenci�n de la imagen 
%Si la imagen se toma con matlab
camera=videoinput('winvideo', 1); %Es la c�mara que estamos usando 
set(camera, 'ReturnedColorspace', 'rgb') %Establece que la imagen obtenida sea RGB
preview(camera); %Muestra una vista previa de la c�mara
pause(5) %Muestra la vista previa por 5 segundos
closepreview(camera); %Cierra la vista previa de la c�mara
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
nivel=graythresh(frame); %Calcula el umbral para la binarizaci�n

%% Tercera etapa: procesamiento de la imagen
%Binarizar e invertir
frame=im2bw(frame,nivel); %Binarizaci�n de la imagen
%figure, imshow(frame), title("Imagen binarizada") %Muestra la imagen binarizada
frame2=imcomplement(frame); %Invierte los colores de la imagen
%figure,imshow(frame2), title("Imagen invertida") %Muestra la imagen binarizada e invertida

%Filtro
se=strel('rectangle',[50 50]); %Elemento estructurador morfol�gico
frame3=imclose(frame2, se); %Erosi�n y dilataci�n
frame3=medfilt2(frame3); %Suavizado con filtro de mediana

%% Cuarta Etapa: Reconocimiento de imagen. 
%Propiedades: �rea y per�metro
area=regionprops(frame3,'Area'); %Obtiene el �rea con el comando regionprops
perimetro=regionprops(frame3,'Perimeter'); %Obtiene el per�metro con el comando regionprops
area=struct2array(area); %Convierte los datos en formato struct a n�meros en un array
perimetro=struct2array(perimetro); %Convierte los datos en formato struct a n�meros en un array
MaxArea=max(area); %Selecciona el �rea m�s grande
MaxPerimetro=max(perimetro); %Selecciona el per�metro m�s grande

%Reconociemiento de figuras
sf=MaxPerimetro*MaxPerimetro/MaxArea; %Compacidad de la geometr�a
sf=ceil(sf); %Redondeo del valor obtenido
% Clasificaci�n de la figura con base en el resultado de compacidad
if sf >= 1 & sf <14
    text = "Es un c�rculo"
elseif sf >= 15 & sf <19
    text = "Es un cuadrado"
else
    text = "Es un tri�ngulo"
end
% Muestra del resultado
final = insertText(frame,[300 300],text,'FontSize',30);
imshow(final)