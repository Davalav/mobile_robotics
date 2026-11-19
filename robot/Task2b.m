% Task2b.m
% Banan för gruppnumret 3. Resultat: bana = [t x y] till From Workspace.

p = [0.26  0.15;      % toppen
     0.52  0;         % högersidan, övre buken
     0.52 -0.30;
     0.26 -0.45;      % mitten (spetsen)
     0.52 -0.60;
     0.52 -0.90;      % högersidan, nedre buken
     0.26 -1.05;      % botten
     0    -0.90];     % slut, nere till vänster
                      % (start i origo [0 0], där roboten står)

QDMAX = [0.07 0.07];                        % morotens maxfart [m/s]
dt    = 0.04;                               % tid mellan punkterna [s]
q = mstraj(p, QDMAX, [], [0 0], dt, 0);     % en rad [x y] per tidpunkt

t    = (0:size(q,1)-1)' * dt;               % tid för varje punkt [s]
bana = [t q];                               % [tid x y]