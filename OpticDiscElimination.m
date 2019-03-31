function [out]=OpticDiscElimination(input,I) i=1;a=0.9;
    % Phase1-Closing 
    StructuringElement=strel('disk',8); OP1=imclose(input,StructuringElement);
    % Phase2-Thresholded Image
    ThresholdedImage=OP1>a;
    % Phase3-Mask
    Mask=imcomplement(ThresholdedImage); 
    OP2=Mask.*input;
    % Phase4-Reconstructed Image 
    StructuringElement=strel('disk',8);
    OP3=imdilate(OP2,StructuringElement); 
    ReconstructedImage{i}=min(OP3,input);
    % Phase5-The dilations of marker image (OP2) under mask image were repeated until the contour of OP2 fits under the mask image. while(1)
        StructuringElement=strel('disk',8); 
        o=imdilate(ReconstructedImage{i},StructuringElement); 
        i=i+1;
        ReconstructedImage{i}=min(o,input); 
        if(ReconstructedImage{i}==ReconstructedImage{i-1})
            break;
        end 
    end 
    % Phase6- Theresholding the difference between the original image and the reconstructed image using otsu algorithm 
    d=input-ReconstructedImage{i};
    alpha = Otsu(d,256);
    OP4=d>=alpha;
    % Phase7- Identifing the optic disc as the largest area and masking out it.
    se=strel('disk',8);
    connectedRegion=imclose(OP4,se);
    CC = bwconncomp(connectedRegion); 
    stats = regionprops(CC, 'all'); 
    L = labelmatrix(CC); 
    sz=size(stats,1);
    matrix=[];
    for i=1:sz
        matrix=[matrix,stats(i).Area];
    end 
    [~,index]=max(matrix); 
    OP5=zeros(size(I)); 
    OP5(stats(index).PixelIdxList)=255; 
    out=(255-OP5)./255;
end