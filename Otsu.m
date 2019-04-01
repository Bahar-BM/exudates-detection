function [T] = Otsu(I,N) 
    nbins = N;
    [x,h] = imhist(I,nbins); 
    p = x./sum(x);
    om1 = 0;
    om2 = 1;
    mu1 = 0;
    mu2 = mode(double(I(:))); 
    for t = 1:nbins-1
        om1(t) = sum(p(1:t));
        om2(t) = sum(p(t+1:nbins));
        mu1(t) = sum(p(1:t).*[1:t]');
        mu2(t) = sum(p(t+1:nbins).*[t+1:nbins]');
    end
    sigma = (mu1(nbins-1).*om1-mu1).^2./(om1.*(1-om1)); 
    idx = find(sigma == max(sigma));
    T = h(idx(1));
end
