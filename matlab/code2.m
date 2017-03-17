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
Tm = 48;
Tn = 3;

% Normalize the image, resize, convert to single precision and display
a = imnorm('lena512color.tiff');
a = imresize(a, [W W]);
x = im2single(a);
figure(1); clf; imagesc(x);

t = imtile(x,R,K,S);

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
                y_local = y(:,:,:);
                % Load weights
                w_local = w(:,:,:,:);
                % Load input feature map
                x_local = x(:,:,:);
                %x_local = cell2mat(t(row:col));
                
                for trr = row:min(row-1+Tr, R)
                    for tcc = col:min(col-1+Tc, C)
                        for too = to:min(to-1+Tm, M)
                            for tii = ti:min(ti-1+Tn, N)
                                for i = 1:K
                                    for j = 1:K
%                                         y(trr,tcc,too) = y(trr,tcc,too)... 
%                                             + w(i,j,tii,too)...
%                                             * x(S*(trr-1)+i,...
%                                             S*(tcc-1)+j,tii);
                                        y_local(trr,tcc,too) = ... 
                                            y_local(trr,tcc,too)... 
                                            + w_local(i,j,tii,too)...
                                            * x_local(S*(trr-1)+i,...
                                            S*(tcc-1)+j,tii);

                                    end
                                end
                            end
                        end
                    end
                end
                % Store output feature maps
%                 y(min(row-1+Tr, R), min(col-1+Tc, C), to ) = y_local;
                y=y_local;
            end
        end
    end
end


% Output profiling data
profile viewer

% Display the 48 filter outputs
figure(2); clf; vl_imarraysc(y); colormap gray;
