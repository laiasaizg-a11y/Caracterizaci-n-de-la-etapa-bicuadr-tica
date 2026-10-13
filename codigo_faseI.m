% PARAMETROS TEORICOS DEL FILTRO
H0 = -0.4377;
xi = 0.227;
w0 = 13107;

% RESPUESTA FRECUENCIAL
% Barrido desde w0/100 hasta 100*w0
w = logspace(log10(w0/100), log10(100*w0), 2000);

% Evaluacion de la funcion de transferencia para s = j*w
s = 1i*w;

Gjw = (H0*2*xi*w0.*s) ./ (s.^2 + 2*xi*w0.*s + w0^2);

% Magnitud en decibelios y fase en grados
magnitud_dB = 20*log10(abs(Gjw));
fase_grados = unwrap(angle(Gjw))*180/pi;

% Diagrama de Bode
figure;

subplot(2,1,1);
semilogx(w, magnitud_dB, 'LineWidth', 1.5);
xlim([100 w(end)*(w(1)/100)]);
grid on;
xlabel('Frecuencia angular (rad/s)');
ylabel('Magnitud (dB)');
title('Diagrama de Bode del filtro paso banda');

subplot(2,1,2);
semilogx(w, fase_grados, 'LineWidth', 1.5);
xlim([100 w(end)*(w(1)/100)]);
grid on;
xlabel('Frecuencia angular (rad/s)');
ylabel('Fase (grados)');

% RESPUESTA A UN ESCALON UNITARIO
% Tiempo expresado en segundos
t = 0:1e-6:3e-3;

c = (2*xi*H0/sqrt(1-xi^2)) .* sin(w0*t*sqrt(1-xi^2)) .* exp(-xi*w0*t);

% Representacion temporal con el eje en milisegundos
figure;

plot(t*1000, c, 'LineWidth', 1.5);
grid on;
xlabel('Tiempo (ms)');
ylabel('Salida (V)');
title('Respuesta a un escalon unitario de 1 V');