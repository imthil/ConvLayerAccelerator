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

% Implement a 11x11x3 48 linear filter bank with random coefficients
w = randn(K, K, N, M, 'single');

% Start profiling
profile on;
DRAM = 0;
% Perform convolution of the input as per Code 1
y=zeros(R, C, M);
for row = 1:R 
    for col = 1:C
        for to = 1:M
            for ti = 1:N
                for i = 1:K
                    for j = 1:K
                        y(row,col,to) = y(row,col,to)... 
                            + w(i,j,ti,to) * x(S*(row-1)+i,S*(col-1)+j,ti);
                        % Access to y (read and write), x(read) and w(read)
                        DRAM = DRAM + 4;
                    end
                end
            end
        end
    end
end


% Output profiling data
profile viewer
fprintf('Number of DRAM Access: %d\n',DRAM);
% Display the 48 filter outputs
% figure(2); clf; vl_imarraysc(y); colormap gray;
