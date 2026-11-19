rosshutdown
rosinit('192.168.67.128', 11311)
sub = rossubscriber('/scan', 'sensor_msgs/LaserScan');

figure(1); clf                                  
h = plot(NaN, NaN, 'b.');
hold on                                         
plot(0, 0, 'r^', 'MarkerFaceColor', 'r')
axis equal
grid on                                        
xlim([-4 4]); ylim([-4 4])
xlabel('x [m] (framåt)'); ylabel('y [m] (vänster)')   

for k = 1:300
    msg = receive(sub,2);

    % Mathematics
    r = double(msg.Ranges(:));
    n = numel(r); % Number of elements
    phi = double(msg.AngleMin) + (0:n-1)' * double(msg.AngleIncrement);
    ok = isfinite(r) & r >= msg.RangeMin & r <= msg.RangeMax;
    x = r(ok) .* cos(phi(ok));
    y = r(ok) .* sin(phi(ok));

    % Plotting
    set(h, 'XData', x, 'YData', y)
    title(sprintf('%d giltiga punkter | närmast %.2f m | längst bort %.2f m', ...
                  sum(ok), min(r(ok)), max(r(ok))))
    drawnow
end

fprintf('range_min = %.2f m, range_max = %.2f m, %d strålar, %.2f grader mellan\n', ...
        msg.RangeMin, msg.RangeMax, n, rad2deg(msg.AngleIncrement))
save('task4a_vm_scan.mat', 'msg', 'x', 'y')
exportgraphics(figure(1), 'task4a_vm_lidar.png', 'Resolution', 300)
rosshutdown               


