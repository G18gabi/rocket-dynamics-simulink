function rocket_init()
% Rakéta paraméterek inicializálása
clear variables;


Re = 6.371e6;

% Kezdeti állapotok
h0 = 0;      %kezdeti magasság
r0 = h0 + Re;   
Vr0 = 0;         % [m/s]
Vv0 = 0;         % [m/s] 
mrc0 = 1000;       % [kg] rakéta üres kezdeti tömege
mf0 = 100;       % [kg] üzemanyag kezdeti tömege
m0 = mrc0 + mf0;       % [kg] rakéta kezdeti tömege
ballistic = false;

% Rakéta paraméterek
Cd = 0.5;                    % Légellenállási tényező
Cl = 0.4;
A = 1.0;                     % Referencia terület [m²]
F_thrust = 50000;             % Tolóerő [N]
m_dot = 5;                   % Tömegáram [kg/s]
cmd_angle = deg2rad(65);         % Emelkedési szög [rad]

% Szimulációs paraméterek
sim_time = 1000;              % Szimulációs idő [s]

% Mentsük el a workspace-be
assignin('base', 'r0', r0);
assignin('base', 'Vr0', Vr0);
assignin('base', 'Vv0', Vv0);
assignin('base', 'm0', m0);
assignin('base', 'Re', Re);
assignin('base', 'mrc0', mrc0);
assignin('base', 'Cd', Cd);
assignin('base', 'Cl', Cl);
assignin('base', 'A', A); 
assignin('base', 'F_thrust', F_thrust);
assignin('base', 'm_dot', m_dot);
assignin('base', 'cmd_angle', cmd_angle);
assignin('base', 'sim_time', sim_time);
assignin('base', 'ballistic', ballistic);

fprintf('Rakéta paraméterek inicializálva!\n');
end