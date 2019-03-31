function [out]=ExudatesDetection(input,I) 
    %Phase1- Closing
    se=strel('disk',8);
    bw1=imclose(I,se);
    %Phase2- Apply Local Variation
    E2=local_variation(bw1,I);
    %Phase3- Threshold image using Otsu algorithm
    T = Otsu(E2,256); E3=E2>T;
    %Phase4- Fill holes 
    se=strel('disk',2); 
    B=imopen(E3,se); 
    B1=imfill(1-B); 
    E4=B.*B1;
    %Phase5- Remove Optic Disc
    se=strel('disk',15); 
    B2=imdilate(255-input,se); 
    se=strel('disk',9); 
    E4=imclose(E4,se); 
    E5=((255-B2).*E4)>0; 
    %Phase6- Create Marker Image 
    E6=I.*(1-E5);
    %Phase7- Morphological Reconstruction
    E7 = imreconstruct(E6, I);
    %Phase8- Threshold on Result image
    B3=I-double(E7); 
    alpha=0.05; 
    out=B3>=alpha; 
end