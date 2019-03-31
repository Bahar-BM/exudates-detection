function [out,I]=Preprocessing(input) %Phase1- RGB to HSI HSI=rgb2hsv(input);
I=HSI(:,:,3);
%Phase2- Apply Median Filter on I band
Median=medfilt2(I,[3,3]);
%Phase3- Apply Contrast Enhancement on I band
out = adapthisteq(Median);