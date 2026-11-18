% plot_task1b.m
% Plottar en körning med den riktiga roboten (Task 1a/1b).
% Kör EFTER att simuleringen har stoppats.

% --- Ändra för varje körning ---
goal = [1 2 pi/2];                          % [x y theta], samma som Goal och Goal_theta
namn = 'task1b_robot_1_2_90';               % filnamn för den här körningen
mapp = fullfile('robot', 'Results', 'Task1b');

% --- Hämta loggade data ---
pose  = out.pose;               % robotmodellen sparar i out (Single simulation output)
t     = pose.Time;              % tid [s]
x     = pose.Data(:,1);         % x-position [m]
y     = pose.Data(:,2);         % y-position [m]
theta = pose.Data(:,3);         % yaw [rad]

% --- Figur 1: banan i XY-planet ---
figure(1)
clf
plot(x, y)                      % robotens bana
hold on
plot(x(1), y(1), 'go')          % start
plot(goal(1), goal(2), 'rx')    % målpunkt

L = 0.1;                                    % pilarnas längd [m]
k = round(linspace(1, length(t), 30));      % 30 utvalda punkter
quiver(x(k), y(k), L*cos(theta(k)), L*sin(theta(k)), 0)              % robotens riktning
quiver(goal(1), goal(2), 2*L*cos(goal(3)), 2*L*sin(goal(3)), 0, 'r') % önskad slutriktning

axis equal
grid on
xlabel('x [m]')
ylabel('y [m]')
title('Task 1b: robotens bana')
legend('Bana', 'Start', 'Mål', 'Riktning', 'Önskad slutriktning')

% --- Figur 2: x, y och yaw över tid ---
figure(2)
clf

subplot(3,1,1)
plot(t, x)
hold on
yline(goal(1), 'r--')           % önskat x
grid on
ylabel('x [m]')
title('Position och yaw över tid')

subplot(3,1,2)
plot(t, y)
hold on
yline(goal(2), 'r--')           % önskat y
grid on
ylabel('y [m]')

subplot(3,1,3)
plot(t, theta)
hold on
yline(goal(3), 'r--')           % önskad slutvinkel
grid on
ylabel('yaw [rad]')
xlabel('tid [s]')

% --- Slutläge och fel ---
fprintf('Slutläge: x = %.3f m, y = %.3f m, theta = %.1f grader\n', ...
        x(end), y(end), rad2deg(theta(end)))
fprintf('Fel: avstånd = %.3f m, vinkel = %.1f grader\n', ...
        sqrt((goal(1)-x(end))^2 + (goal(2)-y(end))^2), ...
        rad2deg(atan2(sin(goal(3)-theta(end)), cos(goal(3)-theta(end)))))

% --- Spara data och bilder ---
save(fullfile(mapp, [namn '.mat']), 'pose', 'goal')
exportgraphics(figure(1), fullfile(mapp, [namn '_xy.png']), 'Resolution', 300)
exportgraphics(figure(2), fullfile(mapp, [namn '_t.png']),  'Resolution', 300)