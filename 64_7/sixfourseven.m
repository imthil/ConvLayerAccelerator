% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 17-March-2017

%Params
Tm = 64;
Tn = 7;

% Set input and output feature map
N = single(ones(1,Tn));
M = single(zeros(1,Tm));

% Set filter weights
% For simplicity lets assume all wieghts are the same
W = single([1 0.95 0.85 0.25 0 0 0.45]); 

% Do computation across all PEs to get M
M = mac( M, N, W, Tm, Tn );

checker = 1;
for check = 1:Tm-1
    if M(check) == M(check+1)
        checker = checker + 1;
    end
end

if checker == Tm 
    fprintf('Passed with value %d for each %d feature(s)\n', M(1), Tm);
end