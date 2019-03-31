clc
close all;
clear all;
for i=1:20
input=imread(strcat('STARE\img (',int2str(i),').tif'));
%Stage1- Preprocessing
[stage1,I]=Preprocessing(input); imwrite(stage1,strcat('Preprocessing\prp (',int2str(i),').jpg')); %Stage2- Optic Disc Elimination stage2=OpticDiscElimination(stage1,I); imwrite(stage2,strcat('OpticDiscElimination\ode (',int2str(i),').jpg'));
%Stage3- Exudates Detection
stage3=ExudatesDetection(stage2,I); imwrite(stage3,strcat('ExudatesDetection\ed (',int2str(i),').jpg')); end