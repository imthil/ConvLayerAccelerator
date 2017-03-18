% Author: Thilina Mallawa Arachchi
% Email address: thilina@ieee.org  
% March 2017; Last revision: 17-March-2017

function Tm = mac( M, N, W, Tm, Tn )
%MAC simply multiplies and accumalates

M_local = M;
N_local = N;
W_local = W;

for mm = 1:Tm
    for nn = 1:Tn
        % Processing Element
        M_local(mm) = M_local(mm) + N_local(nn)*W_local(nn);
    end
end


Tm = M_local;
end

