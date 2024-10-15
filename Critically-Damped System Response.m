% Parameter dari manipulator
 L = 0.5; % Panjang lengan dalam meter
 m = 6; % Berat dalam kilogram
 % Momen inersia untuk batang dengan distribusi massa 
seragam (asumsi sederhana)
 I = (1/3) * m * L^2; % Momen inersia
 % Transfer function dari motor DC yang tertera pada 
gambar
 num_motor = 1;
 den_motor = [I, 6, 10, 0];
 motor_tf = tf(num_motor, den_motor);
 % Menampilkan transfer function motor
 disp('Transfer function dari motor DC:');
 disp(motor_tf);
% Menentukan parameter PID 
Kp = 4.9;
 Ki = 0;
 Kd = 0;
 % Membuat PID controller
 PID_controller = pid(Kp, Ki, Kd);
 % Menampilkan parameter PID
 disp(['Kp: ', num2str(Kp)]);
 disp(['Ki: ', num2str(Ki)]);
 disp(['Kd: ', num2str(Kd)]);
 % Simulasi sistem dengan PID controller
 sys_cl_pid = feedback(PID_controller * motor_tf, 1);
 % Setpoint 1 radian
 setpoint = 1; % dalam radian
 % Membuat step input dengan nilai setpoint 1 radian
 time = 0:0.01:100; % waktu simulasi dari 0 hingga 10 detik
 input_signal = setpoint * ones(size(time));
 % Simulasi sistem
 [response, t] = step(setpoint * sys_cl_pid, time);
 % Mengambil informasi step response
 info = stepinfo(response, t, setpoint);
 overshoot = info.Overshoot;
 riseTime = info.RiseTime;
 settlingTime = info.SettlingTime;
 % Menghitung time constant
 % Asumsi time constant adalah waktu yang dibutuhkan 
untuk mencapai 63.2% dari nilai akhir
 final_value = setpoint;
 time_constant_index = find(response >= 0.632 * 
final_value, 1);
 time_constant = t(time_constant_index);
 % Plot hasil simulasi
 figure;
 plot(t, response);
 xlabel('Waktu (detik)');
 ylabel('Sudut (radian)');
 title('Response Critically Damped');
 grid on;
 % Menampilkan overshoot, rise time, settling time, dan 
time constant pada grafik
 text(0.1, 0.9, sprintf('Overshoot: %.2f%%', overshoot), 
'Units', 'normalized');
 text(0.1, 0.8, sprintf('Rise Time: %.2f s', riseTime), 'Units', 
'normalized');
 text(0.1, 0.7, sprintf('Settling Time: %.2f s', settlingTime), 
'Units', 'normalized');
 text(0.1, 0.6, sprintf('Time Constant: %.2f s', 
time_constant), 'Units', 'normalized');
