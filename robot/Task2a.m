% make_traj_task2.m
% Skapar banan som målpunkten (moroten) följer i Task 2a.
% Resultat: variabeln bana = [t x y] till From Workspace-blocket.

p = [0.8 0;                     % kvadratens hörn [m]
     0.8 0.8;
     0   0.8;
     0   0];
varv = 2;                       % antal varv
via  = repmat(p, varv, 1);      % hörnen upprepade varv gånger

QDMAX = [0.1 0.1];              % morotens maxfart i x och y [m/s]
dt    = 0.04;                   % tid mellan punkterna [s]
q = mstraj(via, QDMAX, [], [0 0], dt, 0);   % banan: en rad [x y] per tidpunkt

t    = (0:size(q,1)-1)' * dt;   % tid för varje punkt [s]
bana = [t q];                   % [tid x y]