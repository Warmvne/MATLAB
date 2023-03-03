%%%%%%%%%%%%%%% UPLOADER LE FICHER EXTRACTFACE ET EYEPOSITON DISPO SUR BOOSTCAMP %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%            UPLOADER LE FICHIER CROP_A.M DISPO SUR BOOSTCAMP      %%%%%%%%%%%%%%%%%%%%%%%%%

I=imread('18-4.jpg');
UknownFace=extract_Face(I);

load("CropA.mat");

clear X
for i=1:size(Crop,3)
    X(:,i)=reshape(Crop(:,:,i),[10000 1]);
end

averageFace=mean(X,2);
A=double(X)-averageFace;
[U,S,V]=svds(A,20);

LTFaces=(U(:,1:20)')*A;
LUnknownFace=U(:,1:20)'*(reshape(double(UknownFace),[10000 1])-averageFace);
euclideanDist=sqrt(sum((LTFaces-LUnknownFace).^2));

[minScore,match]=min(euclideanDist);
imagesc(Crop(:,:,match));

  
  
  
