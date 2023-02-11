//////////////////////////////////// créer un fichier eyePosition.m /////////////////////////////////

%la fonction prend en entrée un objet qui est une image et renvoi un vecteur de coordonées
function [cL,cR] = eyePosition(I)
  
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%show the image
image(I);

%%%%%%%%%%%%%%%%%% clique gauche %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%afficher un message
htext=text(50,50,'Please click on the eye on the left');

% défini la couleur du texte
set(htext,'Color',[0,1,0]);

%récupère les coordonnées du click gauche
cL=ginput(1);

%efface le message
delete(htext);

%%%%%%%%%%%%%%%%%% clique droit %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%affiche un message
htext=text(50,50,'Please click on the eye on the right');

% défini la couleur du texte
set(htext,'Color',[0,1,0]);

%récupère les coordonées du click droit
cR=ginput(1);

%efface le message
delete(htext);

end

//////////////////////////////////// créer un fichier ExtractCar.m /////////////////////////////////

% la fonction prend en entrée un objet qui va être une image et qui renvoi une matrice contenant l'image réduite de la voiture
function [crop] = ExtractCar(P1)
  
% tu récupères les coordonées des click
[A,D]=eyePosition(P1);

% tu récupères l'angle de la photo
angle=atan2d(D(2)-A(2),D(1)-A(1));

% ça retourne la photo dans le bon sens
crop=imrotate(P1,angle,'crop');

%creation de la matrice de rotation R
R=[cosd(-angle) -sind(-angle);sind(-angle) cosd(-angle)];

%creation des nouvelles coordonées des cliques après avoir tourné la photo
newA=R*(A-flip(size(rgb2gray(P1))/2))'+flip(size(rgb2gray(P1))/2)';
newD=R*(D-flip(size(rgb2gray(P1))/2))'+flip(size(rgb2gray(P1))/2)';

%affiche l'image mais on le verra pas au moment du fonctionnement du code
image(crop);

hold on
% on met des cercles à l'endroit des clicks
plot(newA(1),newD(2),'go');
plot(newD(1),newA(2),'go');
hold off;

% on definit une distance s entre les 2 clicks
s=abs(newD(1)-newA(1));

% on reduit la taille de l'image
crop=imcrop(crop,[newA(1) newA(2)-(s/ 4) s s/2]);
crop=imresize(crop,[150 400]);

% on passe l'image en niveaux de gris
crop=rgb2gray(crop);

%%%%% ignore la ligne d'en dessous %%%%%
%imagesc(crop);

%tu définis l'échelle pour l'image qui doit être de 400X150
RI = imref2d(size(crop));
RI.XWorldLimits = [0 400];
RI.YWorldLimits = [0 150];

% afficahge de l'image finale
figure;
imshow(crop,RI);

%%%%% ignore les 2 lignes en dessous car ça marche pas %%%%%
%si je veux améliorer la qualité de l'image je fais ça:
% imshow(corn_detail,'InitialMagnification',1000,'Interpolation',"bilinear")


end


//////////////////////////// pour tester le code tu mets ça dans la Command Window ////////////////////////

// créer un objet qui contient l'image de la voiture
P1=imread("nom de l'image.jpg") // puis tu fais entrer

// tu tournes l'image de 45°
P1=imrotate(P1,45) // puis tu fais entrer

// tu fais fonctionner le code pour extraire la voiture
ExtractCar(P1)


