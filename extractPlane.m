function [Crop] = extractPlane(I)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%input is an RGB image
[cL,cR] = eyePosition(I);

%atand de 0 à 90 et atan2d de 0 à 180
angle=atan2d(cR(2)-cL(2),cR(1)-cL(1));

Crop=imrotate(I,angle,'crop');

%récupération des nouvelles coordonées des yeux (ne pas oublier le ' pour
%transposer le vecteur [x,y] en [x]
%                               [y]

R=[cosd(angle) sind(angle);-sind(angle) cosd(angle)];
newcL=R*(cL-flip(size(rgb2gray(I)))/2)'+(flip(size(rgb2gray(I)))/2)';
newcR=R*(cR-flip(size(rgb2gray(I)))/2)'+(flip(size(rgb2gray(I)))/2)';
image(Crop);
%vérification des nouvelles coordonnées
hold on;
plot(newcL(1),newcL(2),'go');
plot(newcR(1),newcR(2),'bo');
hold off;

s=sqrt(((newcR(1)-newcL(1))^2)+(newcR(2)-newcL(2))^2);
%Crop=imcrop(Crop,[cL(1)-(s/2) cL(1)-(s/2) 2*s 2*s]);
Crop=imcrop(Crop,[newcL(1) newcL(2)-s/4 s s/2]);
Crop=imresize(Crop,[100,200]);
image(Crop);

end
