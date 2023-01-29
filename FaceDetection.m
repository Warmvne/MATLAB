%Charger l'image
img = imread('image.jpg');

% Convertir l'image en niveaux de gris
img_gray = rgb2gray(img);

% Appliquer un filtre de convolution pour détecter les caractéristiques du visage
filter = fspecial('average', [10 10]);
img_filtered = imfilter(img_gray, filter);

% Appliquer un seuil pour isoler les zones les plus claires (visages)
img_thresholded = img_filtered > 128;

% Utiliser morphological operations pour améliorer les résultats
se = strel('disk', 5);
img_open = imopen(img_thresholded, se);
img_close = imclose(img_open, se);

% Rechercher les régions connexes (visages)
cc = bwconncomp(img_close);

% Tracer un rectangle autour des visages
for i = 1:cc.NumObjects
    obj = cc.PixelIdxList{i};
    [y, x] = ind2sub(size(img_close), obj);
    bbox = [min(x), min(y), max(x) - min(x), max(y) - min(y)];
    img = insertShape(img, 'Rectangle', bbox, 'LineWidth', 2);
end

% Afficher l'image avec les visages détectés
imshow(img);
