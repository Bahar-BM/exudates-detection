function result=local_variation(inp1,inp2) 
    win=7;
    %Normalizing Image
    maxx=max(inp1(:));
    minn=min(inp1(:)); 
    result=(inp1-minn); 
    temp=255/(maxx-minn); 
    NormalizedImage=uint8(result*temp); 
    [R,C]=size(inp2); 
    result=zeros(R,C); 
    result=double(result);
    for i=ceil(win/2):floor(R-(win/2)) 
        for j=ceil(win/2):floor(C-(win/2))
            k=floor(win/2); 
            mm=double(NormalizedImage(i-k:i+k,j-k:j+k)); 
            [m,n]=size(mm);
            meann=mean(mm(:));
            N=m*n-1; 
            result(i-k:i+k,j-k:j+k)=double(((mm-meann).^2)/N); 
        end
    end
end