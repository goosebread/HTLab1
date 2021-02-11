%Alex Yeh 2/5/2021
%HT Lab 1

%gives magnitude of g and the zero acceleration value
%takes in raw data of gravity acting when board is facing up 
%and when board is facing down
function [gval,gzero]=gcalibrate(upFile,downFile,time,sr)
    g1=getAverage(upFile,time,sr);
    g2=getAverage(downFile,time,sr);
    gzero=(g1+g2)/2;
    gval=(g1-g2)/2;
end