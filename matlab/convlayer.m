% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 7-March-2017

% Normalize the image, convert to single precision and display
a = imnorm('lena512color.tiff');
x = im2single(a);
figure(1); clf; imagesc(x);

% Implement a 5x5x3 10 linear filter bank with random coefficients
w = randn(5,5,3,10,'single');

% Start profiling
profile on;

% Perform convolution of the input with the filter bank and apply
% downsampling using a stride factor
y = vl_nnconv(x,w, [], 'stride', 4);

% Output profiling data
profile viewer

% Display the 10 filter outputs
figure(2); clf; vl_imarraysc(y); colormap gray;
