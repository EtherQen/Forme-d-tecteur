clear all;
close all;
clc;
J = imread('download.png', 'png');
%%

I = J(:,:,1);
figure;
imshow(I), shg

%imhist(I)

%% Seuillage

[H, W] = size(I);

for i=1:H
    for j = 1:W
        if I(i,j) > 150
            I(i,j) = 255;
        else I(i,j) = 0;
        end
    end
end

imshow(I)

%% Horizontal scan
K = I;
j = 1;
a = 0;
b = 0;
for i = 1:H
	while (j < ceil(W/2)+1 && (a*b) == 0)
		if I(i,j) == 255
			K(i,j) = 50;
        else
            a = 1;
		end
	
		if I(i,W+1-j) == 255
			K(i,W+1-j) = 50;
        else
            b = 1;
		end
		j = j + 1;
    end
    j = 1;
    a = 0;
    b = 0;
end

%% Vertical scan

% i = 1;
% j = 1;
% a = 0;
% b = 0;
% for i = 1:W
% 	while (j < ceil(H/2)+1 && (a*b) == 0)
% 		if I(i,j) == 255
% 			K(i,j) = 50;
% 		else a = 1;
% 		end
% 	
% 		if I(i,W+1-j) == 255
% 			K(i,W+1-j) = 50;
% 		else b = 1;
% 		end
% 		j = j + 1;
% 	end
% end

%% Calcul surface du cercle
surf = 0;
for i = 1:H
    for j = 1:W
        if K(i,j) == 255
            surf = surf + 1;
        end
    end
end

%% Calcul rayon du cercle
%Synthétiser une carré (se)
r = floor(sqrt(count/pi));

se = zeros(2*r,2*r);

%% Masquage

[h, w] = size(se);
min_val = surf;

for i = 1:(W-w)
    for j = 1:(H-h)
        I_temp = K;
        for m = 1:h
            for n = 1:w
                I_temp(m-1+i,n-1+j) = I_temp(m-1+i,n-1+j) * se(m,n);
            end
        end
        min_val = min(surf-calcSurface(I_temp), min_val);
    end
end
seuil = 0.01;
temp = seuil*surf;
if min_val < temp
    disp('It s a circle');
else 
    disp('Not a circle');
end




