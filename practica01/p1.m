close all
clear all
clc 
%Se carga la imagen
%im = imread('imagen.png');
load Midbrain.mat
%Se convierte la imagen a escala de grises
%im_g = rgb2gray(im);
im_g = midbrainthesh;
imshow(im_g)
%Se filtra la imagen con un filtro de media en 2d
im_f = medfilt2(im_g);
imshow(im_f)
%Se ajusta el contraste de la imagen
im_a = imadjust(im_f);
%Se obtiene el tamaño de la matriz de la imagen
[ncols,nrows]=size(im_a);
%Se despliega la imagen para obtener la posici'on de 
%los pixeles semilla 
imshow(im_a)
%Se guardan los valores de los pixeles
[x,y] = getpts;
%Se convierte a valores enteros para usar como par'ametros
xi=int32(x);
yi=int32(y);
%Se prueban otros filtros.
filtro5=fspecial('gaussian',[5,5]);
filtro9=fspecial('gaussian',[9,9]);
filtro11=fspecial('gaussian',[11,11]);
imFilG5=imfilter(im_f,filtro5);
imFilG9=imfilter(im_f,filtro9);
imFilG11=imfilter(im_f,filtro11);

%Se cierra la figura creada
close all
%Se binariza la imagen. Calcule el umbral de imagen adaptable
%localmente elegido utilizando estadísticas de imagen 
%de primer orden locales alrededor de cada píxel. 
BW = imbinarize(im_a, 'adaptive');
%Se convierten los valores obtenidos a enteros.
bin = im2uint8(BW);
%Se crea una m'ascara binaria para los pixeles
%con intensidad de gris similar con una tolerancia de 1
bw = grayconnected(im_a,xi,yi,0.1);
%Se obtiene el area total
area = bwarea(bw);
%Se recorta la imagen
im_r = imcrop(bw,[xi-45,yi-30,90,70]);
%Se muestran los resultados
figure
subplot(3,3,1),imshow(im_g),title('Original')
subplot(3,3,2),imhist(im_g,128),title('Histograma de original')
subplot(3,3,3),imshow(im_a),title('Filtrada y ajustada')
subplot(3,3,4),imhist(im_a,128),title('Histograma filtrado y ajustado')
subplot(3,3,5),imshow(bw),title('Mesencéfalo')
subplot(3,3,6),imshow(im_r),title('Imagen recortada')
subplot(3,3,7),imshow(imFilG5),title('Gaussiano 5X5')
subplot(3,3,8),imshow(imFilG9),title('Gaussiano 9X9')
subplot(3,3,9),imshow(imFilG11),title('Gaussiano 11X11')