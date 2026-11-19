% Task3.m
% Linjen som roboten ska följa. Resultat: variabeln L till Simulink.

a = 0.5;              % lutning       (Task 3a: 2,   Task 3b: 0.5)
b = 4;              % y vid x = 0   (Task 3a: 0,   Task 3b: 4)

% Labbens y = a*x + b skrivs om till föreläsningens form
% L(1)*x + L(2)*y + L(3) = 0, alltså -a*x + 1*y - b = 0
L = [-a 1 -b];