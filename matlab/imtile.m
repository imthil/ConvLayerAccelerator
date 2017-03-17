% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 15-March-2017

function imagetile = imtile(image, outputsize, kernelsize, stride)
% This function calculates the individual receptive fields seen by
% a neuron


R = outputsize;
C = R;

%x_local=zeros(R,C,3);

for i = 1:R
    for j = 1:C
        r_low   = stride*(i-1)+1;
        c_low   = stride*(j-1)+1;
        r_high  = stride*(i-1)+kernelsize;
        c_high  = stride*(j-1)+kernelsize;
        x_local{i,j} = image(r_low:r_high,c_low:c_high,:);
        %x_local = image(r_low:r_high,c_low:c_high,:);
        %figure(2); clf;imagesc(x_local);
        
    end
end
imagetile = x_local;
    
end