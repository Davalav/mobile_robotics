
t = pose.Time;
x = pose.Data(:,1);
y = pose.Data(:,2);
theta = pose.Data(:,3);

goal = [-3 -3];

% --- Figur 1: banan i XY-planet ---
figure(1)
clf                            
plot(x, y)                      
hold on                        
plot(x(1), y(1), 'go')         
plot(goal(1), goal(2), 'rx')    

L = 0.1;              % pilens längd [m]
k = round(linspace(1, length(t), 30)); 
quiver(x(k), y(k), L*cos(theta(k)), L*sin(theta(k)), 0)

axis equal                      
grid on
xlabel('x [m]')
ylabel('y [m]')
title('Task 1a: robotens bana')
legend('Bana', 'Start', 'Mål', 'Riktning')

% --- Figur 2: x, y och yaw över tid ---
figure(2)
clf                             % töm figuren från förra körningen

subplot(3,1,1)                  % ruta 1 av 3: x
plot(t, x)
grid on
ylabel('x [m]')
title('Position och yaw över tid')

subplot(3,1,2)                  % ruta 2 av 3: y
plot(t, y)
grid on
ylabel('y [m]')

subplot(3,1,3)                  % ruta 3 av 3: yaw
plot(t, theta)
grid on
ylabel('yaw [rad]')
xlabel('tid [s]')               % tidsaxeln bara på den nedersta

% --- Spara data och bilder i vm/Results/Task1a ---
mapp = fullfile('vm', 'Results', 'Task1a');
namn = sprintf('task1a_goal_%g_%g', goal(1), goal(2));
save(fullfile(mapp, [namn '.mat']), 'pose')
exportgraphics(figure(1), fullfile(mapp, [namn '_xy.png']), 'Resolution', 300)
exportgraphics(figure(2), fullfile(mapp, [namn '_t.png']),  'Resolution', 300)