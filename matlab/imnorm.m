% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 7-March-2017

function imagenorm = imnorm(filepath)
% This function calculates the normalized image of the
% image file given as input
a = imread(filepath);
c = double(a);
r = c(:,:,1);
g = c(:,:,2);
b = c(:,:,3);

[row, col] = size(c(:,:,1));

for i = 1:row
    for j = 1:col
        r_pixel = r(i,j);
        g_pixel = g(i,j);
        b_pixel = b(i,j);

        denom = sqrt(r_pixel^2+g_pixel^2+b_pixel^2);
        
        r_norm = r_pixel/denom;
        g_norm = g_pixel/denom;
        b_norm = b_pixel/denom;
        
        r(i,j) = r_norm;
        g(i,j) = g_norm;
        b(i,j) = b_norm;
    end
end


c(:,:,1) = r;
c(:,:,2) = g;
c(:,:,3) = b;

imagenorm = c;
end