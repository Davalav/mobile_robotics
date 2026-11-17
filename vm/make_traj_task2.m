fall = 'sinus';


if strcmp(fall, 'kvadrat')
    p = [1 0;1 1;0 1;0 0];
    varv = 2;
    via = repmat(p, varv, 1);

elseif strcmp(fall, 'S')
    r = 0.4;

    v1 = linspace(deg2rad(30), deg2rad(270), 15)';
    ovre = [r*cos(v1), r + r*sin(v1)];

    v2 = linspace(deg2rad(90), deg2rad(-150), 15)';
    nedre = [r*cos(v2), -r + r*sin(v2)];

    via = [ovre; nedre(2:end, :)];
    via = via -via(1,:);
    via = via(2:end,:);

elseif strcmp(fall, 'sinus')
    A      = 0.3;                       % amplitud [m]
    lambda = 2.5;                       % våglängd [m]
    L      = 5;                         % banans längd i x [m], två vågor

    x = linspace(0, L, 41)'; 
    y = A * sin(2*pi*x / lambda); 

    via = [x y];                
    via = via(2:end,:);   

end


QDMAX = [0.1 0.1];
dt = 0.04;

q = mstraj(via, QDMAX, [], [0 0], dt, 0);

t = (0:size(q,1)-1)'*dt;
traj = [t q];

figure(3); clf
plot(q(:,1), q(:,2), '.-')
axis equal;
grid on
title("Task 2a")

