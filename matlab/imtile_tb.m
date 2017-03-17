% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 7-March-2017

% Layer Params
W = 224;    % Dim of Input Map
M = 48;     % No. Output Features
N = 3;      % No. Input Features
K = 11;     % Filter Block Size
S = 4;      % Stride
P = 0;      % Padding
R = round((W-K+2*P)/S + 1); % Dim of Ouput Map
C = R;

% Normalize the image, resize, convert to single precision and display
a = imnorm('lena512color.tiff');
a = imresize(a, [W W]);
x = im2single(a);
figure(1); clf; imagesc(x);

tile = imtile(x,R,K,S);