 % Parameter dari manipulator
 L = 0.5; % Panjang lengan dalam meter
 m = 6; % Berat dalam kilogram
 % Momen inersia untuk batang dengan distribusi massa 
seragam (asumsi sederhana)
 I = (1/3) * m * L^2; % Momen inersia
 % Parameter dari motor DC (termasuk konstanta untuk 
menyertakan efek panjang dan berat)
 num_motor = 1;
 den_motor = [I, 6, 10, 0]; % Menggunakan momen inersia 
dalam denominator
 motor_tf = tf(num_motor, den_motor);
 % Menampilkan transfer function motor
 disp('Transfer function dari motor DC dengan panjang dan 
berat manipulator:');
 disp(motor_tf);
 % Variasi parameter PID untuk berbagai kondisi
 PID_configs = {
    4.9, 0, 0, 'Critically Damped'; % Kp, Ki, Kd, Title
    0.1, 0, 0, 'Overdamped';
    72.0, 1.02857, 12.6, 'Response Underdamped 
(Ziegler-Nichols)'
 };
 % Warna untuk plot
 colors = ['b', 'r', 'g', 'm'];
 figure;
 hold on;
 for i = 1:size(PID_configs, 1)
    % Menentukan parameter PID
    Kp = PID_configs{i, 1};
    Ki = PID_configs{i, 2};
    Kd = PID_configs{i, 3};
    % Membuat PID controller
    PID_controller = pid(Kp, Ki, Kd);
    % Menampilkan parameter PID
    disp(['Parameter PID untuk konfigurasi ', PID_configs{i, 
4}, ':']);
    disp(['Kp: ', num2str(Kp)]);
    disp(['Ki: ', num2str(Ki)]);
    disp(['Kd: ', num2str(Kd)]);
    % Simulasi sistem dengan PID controller
    sys_cl_pid = feedback(PID_controller * motor_tf, 1);
    % Setpoint 1 radian
    setpoint = 1; % dalam radian
    % Membuat step input dengan nilai setpoint 1 radian
    time = 0:0.01:300; % waktu simulasi dari 0 hingga 300 
detik
    input_signal = setpoint * ones(size(time));
    % Simulasi sistem
    [response, t] = step(setpoint * sys_cl_pid, time);
    % Plot hasil simulasi dengan warna berbeda untuk setiap 
konfigurasi
    plot(t, response, 'Color', colors(i), 'DisplayName', 
PID_configs{i, 4});
 end
