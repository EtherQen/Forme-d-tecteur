function [ count ] = calcSurface(K)
%SURFACE Calculer surface

[H, W] = size(K);
count = 0;
for i = 1:H
    for j = 1:W
        if K(i,j) == 255
            count = count + 1;
        end
    end
end
return

