function [cL,cR] = eyePosition(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%show the image
image(I);
%afficher un message
htext=text(50,50,'Please click on the eye on the left');
%récupère les coordonnées du click gauche
cL=ginput(1);
%efface le message
delete(htext);
%affiche un message
htext=text(50,50,'Please click on the eye on the right');
%récupère les coordonées du click droit
cR=ginput(1);
%efface le message
delete(htext);

end



%%%%%%%%% pour changer la couleur du texte %%%%%%%%%%%
  
 set(htext,'Color',[0,1,0]);
