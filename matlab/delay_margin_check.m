%% ENME506 Project 6.2 - P2 Control - Milestone 1
% Delay-margin check for the speed loop.
% Plant: Gw(s) = 2/(s^2 + 12s + 20.02)   (J=0.01, b=0.1, K=0.01, R=1, L=0.5)
% PID:   Kp = 100, Ki = 200, Kd = 10
% Result: wc = 19.0 rad/s, PM = 94.6 deg, GM = Inf  ->  tau_max = 87 ms (round trip)

clear; clc; close all;
s = tf('s');

%% 1) Plant and controller
G = 2/(s^2 + 12*s + 20.02);     % motor: voltage -> speed
C = pid(100, 200, 10);          % PID controller
L = C*G;                        % open loop
T = feedback(L, 1);             % closed loop (no delay)

%% 2) Figure 1 - closed-loop step response, no delay
figure; step(T, 2); grid on
title('Closed-loop speed step response (no delay)')
exportgraphics(gcf, 'fig1_step_no_delay.png')

%% 3) Delay margin from the phase margin
[Gm, Pm, Wcg, Wcp] = margin(L);
tau_max = (Pm*pi/180) / Wcp;
fprintf('Crossover wc   = %.2f rad/s\n', Wcp);
fprintf('Phase margin   = %.1f deg\n', Pm);
fprintf('Gain margin    = %g\n', Gm);
fprintf('Delay margin   = %.1f ms (round trip)\n', tau_max*1000);

%% 4) Figure 2 - step response with round-trip delay
figure; hold on
for tau = [0 0.04 0.07 0.10]
    Ld = L;
    Ld.InputDelay = tau;
    step(feedback(Ld, 1), 2.5)
end
legend('0 ms', '40 ms', '70 ms', '100 ms'); grid on
title('Step response vs. round-trip delay')
exportgraphics(gcf, 'fig2_delay_comparison.png')

%% 5) Figure 3 - Bode plot with margins
figure; margin(L); grid on
exportgraphics(gcf, 'fig3_bode_margin.png')
