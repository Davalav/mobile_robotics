% Task2c.m
% Banan för en sinuskurva. Resultat: bana = [t x y] till From Workspace.

A      = 0.2;                   % amplitud [m]: kurvan går mellan y = -0.2 och 0.2
lambda = 2;                     % våglängd [m]: en hel våg på 2 m
L      = 2;                     % banans längd i x [m]

x = linspace(0, L, 21)';        % 21 x-värden, ett var 10:e cm
y = A * sin(2*pi*x / lambda);   % sinusformeln för varje x

p = [x y];                      % punkterna [x y]
p = p(2:end,:);                 % första punkten är origo = startpunkten

QDMAX = [0.1 0.1];                          % morotens maxfart [m/s]
dt    = 0.04;                               % tid mellan punkterna [s]
q = mstraj(p, QDMAX, [], [0 0], dt, 0);     % en rad [x y] per tidpunkt

t    = (0:size(q,1)-1)' * dt;               % tid för varje punkt [s]
bana = [t q];                               % [tid x y]