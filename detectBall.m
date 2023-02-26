% Robotics: Estimation and Learning 
% 
% 
% Complete this function following the instruction. 
function [segI, loc] = detectBall(I)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 
%
% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here
%
 mu = [148.4140 144.0171 62.4389];
 sig = [208.4049 133.1187 3754.4475];
 thre = 0.2e-5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model

[mrows,mcols,D]=size(I);
mask= zeros(mrows,mcols);
prob_den=[];
for i=1:mrows
    for j=1:mcols
        prob_den(i,j)=mvnpdf(double([I(i,j,1),I(i,j,2),I(i,j,3)]),mu,sigma);
        if prob_den(i,j)>thre
            mask(i,j)=1;
        end
    end
end
figure,surf(prob_den);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.
segI=false(mrows,mcols)
CC=bwconncomp(mask);
numPixels= cellfun(@numel,CC.PixelIdxList);
[biggest,idx]= max(numPixels);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the location of the ball center
%

segI(CC.PixelIdxList{idx}) = true;
S = regionprops(CC,'Centroid')
loc = S(idx).Centroid;
% 
% Note: In this assigment, the center of the segmented ball area will be considered.

end
