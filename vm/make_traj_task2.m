p = [1 0;
     1 1;
     0 1;
     0 0];

varv = 3;

via = repmat(p, varv, 1);

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

