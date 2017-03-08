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

% Perform convolution of the input with the filter bank and apply
% downsampling using a stride factor
y = vl_nnconv(x, w, [], 'stride', 4);

% Output profiling data
profile viewer

% Display the 48 filter outputs
figure(2); clf; vl_imarraysc(y); colormap gray;
