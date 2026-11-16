% plot_task1.m
% Plottar resultatet från Task 1. Kör skriptet EFTER att simuleringen stoppats.

% --- Hämta loggade data ---
if exist('pose', 'var')
    data = pose;            % pose ligger direkt i workspace (din modell)
else
    data = out.pose;        % pose ligger inuti out (nyare modeller)
end

t     = data.Time;          % tid [s]
x     = data.Data(:,1);     % x-position [m]
y     = data.Data(:,2);     % y-position [m]
theta = data.Data(:,3);     % yaw [rad]

goal = [1 1];               % samma värde som i Goal-blocket

% --- Figur 1: banan i XY-planet ---
figure(1); clf
plot(x, y, 'b-', 'LineWidth', 1.5); hold on
plot(x(1), y(1), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8)   % start
plot(goal(1), goal(2), 'rx', 'MarkerSize', 12, 'LineWidth', 2)     % mål

% Valfritt: robotens riktning som pilar, 30 st jämnt fördelade längs banan
k = round(linspace(1, length(t), 30));
quiver(x(k), y(k), cos(theta(k)), sin(theta(k)), 0.3, 'k')

axis equal                  % rätt skala, inget utsträckt
grid on
xlabel('x [m]'); ylabel('y [m]')
title('Task 1a: robotens bana')
legend('Bana', 'Start', 'Mål', 'Riktning', 'Location', 'best')

% --- Figur 2: x, y och yaw över tid ---
figure(2); clf
subplot(3,1,1); plot(t, x, 'LineWidth', 1.2); grid on
ylabel('x [m]'); title('Position och yaw över tid')
subplot(3,1,2); plot(t, y, 'LineWidth', 1.2); grid on
ylabel('y [m]')
subplot(3,1,3); plot(t, theta, 'LineWidth', 1.2); grid on
ylabel('yaw [rad]'); xlabel('tid [s]')

% --- Spara data och bilder, med målpunkten i filnamnet ---
namn = sprintf('task1a_goal_%g_%g', goal(1), goal(2));   % t.ex. task1a_goal_1_1
save([namn '.mat'], 'pose')
exportgraphics(figure(1), [namn '_xy.png'], 'Resolution', 300)
exportgraphics(figure(2), [namn '_t.png'],  'Resolution', 300)