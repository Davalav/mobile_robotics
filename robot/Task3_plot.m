% plot_task3.m
% Plottar linjen och robotens bana för Task 3. Kör EFTER att simuleringen stoppats.

% --- Ändra för varje körning ---
namn = 'task3a_robot_y2x';                       % filnamn för den här körningen
mapp = fullfile('robot', 'Results', 'Task3a');   % skapa mappen först

% --- Hämta loggade data ---
pose  = out.pose;               % robotmodellen sparar i out
t     = pose.Time;              % tid [s]
x     = pose.Data(:,1);         % x-position [m]
y     = pose.Data(:,2);         % y-position [m]
theta = pose.Data(:,3);         % yaw [rad]

% --- Linjen från L: L(1)*x + L(2)*y + L(3) = 0  =>  y = -(L(1)*x + L(3)) / L(2) ---
x_linje = linspace(min(x) - 0.5, max(x) + 0.5, 50);   % lite längre än robotens bana
y_linje = -(L(1)*x_linje + L(3)) / L(2);
theta_linje = atan2(-L(1), L(2));                     % linjens riktning theta*

% --- Figur 1: linjen och banan i XY-planet ---
figure(1)
clf
plot(x_linje, y_linje, 'r--')   % linjen
hold on
plot(x, y, 'b')                 % robotens bana
plot(x(1), y(1), 'go')          % start

L_pil = 0.1;                                % pilarnas längd [m]
k = round(linspace(1, length(t), 30));      % 30 utvalda punkter
quiver(x(k), y(k), L_pil*cos(theta(k)), L_pil*sin(theta(k)), 0, 'k')

axis equal
grid on
xlabel('x [m]')
ylabel('y [m]')
title(sprintf('Task 3: y = %gx + %g', -L(1)/L(2), -L(3)/L(2)))
legend('Linjen', 'Robotens bana', 'Start', 'Riktning')

% --- Figur 2: x, y och yaw över tid ---
figure(2)
clf

subplot(3,1,1)
plot(t, x)
grid on
ylabel('x [m]')
title('Position och yaw över tid')

subplot(3,1,2)
plot(t, y)
grid on
ylabel('y [m]')

subplot(3,1,3)
plot(t, theta)
hold on
yline(theta_linje, 'r--')       % linjens riktning: yaw ska lägga sig här
grid on
ylabel('yaw [rad]')
xlabel('tid [s]')

% --- Spara data och bilder ---
save(fullfile(mapp, [namn '.mat']), 'pose', 'L')
exportgraphics(figure(1), fullfile(mapp, [namn '_xy.png']), 'Resolution', 300)
exportgraphics(figure(2), fullfile(mapp, [namn '_t.png']),  'Resolution', 300)