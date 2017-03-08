% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 7-March-2017

% Normalize the image, resize, convert to single precision and display
a = imnorm('lena512color.tiff');
a = imresize(a, [224 224]);
x = im2single(a);
figure(1); clf; imagesc(x);

% Implement a 11x11x3 48 linear filter bank with random coefficients
w = randn(11, 11, 3, 48, 'single');

% Start profiling
profile on;

% Perform convolution of the input as per Code 1
y=zeros(54,54,48);
for row = 1:54
    for col = 1:54
        for to = 1:48
            for ti = 1:3
                for i = 1:11
                    for j = 1:11
                        y(row,col,to) = y(row,col,to)... 
                            + w(i,j,ti,to) * x(4*(row-1)+i,4*(col-1)+j,ti); 
                    end
                end
            end
        end
    end
end


% Output profiling data
profile viewer

% Display the 48 filter outputs
figure(2); clf; vl_imarraysc(y); colormap gray;
