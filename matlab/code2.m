% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 12-March-2017

% Layer Params
W = 224;    % Dim of Input Map
M = 48;     % No. Output Features
N = 3;      % No. Input Features
K = 11;     % Filter Block Size
S = 4;      % Stride
P = 0;      % Padding
R = round((W-K+2*P)/S + 1); % Dim of Ouput Map
C = R;

% Tiling Params
Tr = 4;
Tc = 4;
Tm = 4;
Tn = 3;

% Normalize the image, resize, convert to single precision and display
a = imnorm('lena512color.tiff');
a = imresize(a, [W W]);
x = im2single(a);
figure(1); clf; imagesc(x);

% Implement a 11x11x3x48 linear filter bank with random coefficients
w = randn(K, K, N, M, 'single');

% Start profiling
profile on;

% Perform convolution of the input as per Code 1
y=zeros(R, C, M);
for row = 1:Tr:R 
    for col = 1:Tc:C
        for to = 1:Tm:M
            for ti = 1:Tn:N
                % Load output feature map
                %y_local = y;
                % Load weights
                %w_local = w;
                % Load input feature map
                %x_local = x;
                %r_low   = S*(row);
                %r_high  = S*(row)+K-1;
                %c_low   = S*(col);
                %c_high  = S*(col)+K-1;
                %x_local = x(r_low:r_high,c_low:c_high,1:N);
                
                for trr = 1:min(row+Tr, R)
                    for tcc = 1:min(col+Tc, C)
                        for too = 1:min(to+Tm, M)
                            for tii = 1:min(ti+Tn, N)
                                for i = 1:K
                                    for j = 1:K
                                        y(trr,tcc,too) = y(trr,tcc,too)... 
                                                        + w(i,j,tii,too)...
                                                        * x(S*(trr-1)+i,...
                                                        S*(tcc-1)+j,tii); 
                                    end
                                end
                            end
                        end
                    end
                end
                % Store output feature maps
                %y=y_local;
            end
        end
    end
end


% Output profiling data
profile viewer

% Display the 48 filter outputs
figure(2); clf; vl_imarraysc(y); colormap gray;
