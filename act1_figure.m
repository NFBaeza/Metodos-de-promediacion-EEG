fig1=figure; fig2=figure; fig3=figure; 

figure(fig1)
subplot(2,4,[1 6])
plot(f2,graf2,'b') 
hold on
plot(f3,graf3,'r') 
hold on
plot(f4,graf4,'g') 
hold on
plot(f5,graf5,'m') 
xlim([0 30])
title('Señal EEG en el dominio de la frecuencia segun ancho de ventanas');
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)|');
legend('Ventana largo L/10','Ventana largo L/50', 'Ventana largo L/100','Ventana largo L/200')

subplot(2,4,3)
plot(f2,graf2,'b') 
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)|');
title('Espectro ventana largo L/10');
xlim([0 30])
subplot(2,4,4)
plot(f3,graf3,'r') 
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)|');
title('Espectro ventana largo L/50');
xlim([0 30])
subplot(2,4,7)
plot(f4,graf4,'g') 
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)|');
title('Espectro ventana largo L/100');
xlim([0 30])
subplot(2,4,8)
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)|');
plot(f5,graf5,'m') 
xlim([0 30])
title('Espectro ventana largo L/200');
ylabel('|EEG(f)|');xlabel('Frecuencia [Hz]');

figure(fig2)
subplot(2,2,[1 3])
plot(t,EEGData); 
title('Señal EEG en el tiempo');
xlabel('Tiempo [s]');
xlim([0 325]);ylim([-100 100]);
ylabel('EEG(t)');
subplot(2,2,2)
plot(f,graf1,'b')
xlim([0 1024])
title('Señal EEG en el dominio de la frecuencia');
xlabel('Frecuencia [Hz]');
ylabel('|EEG(f)|');
subplot(2,2,4)
plot(f,20*log10(graf1),'b')
xlim([0 250])
title('Señal EEG en el dominio de la frecuencia');
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)| [db]');

figure(fig3)
subplot(2,4,[1 6])
plot(f2,graf2_db,'b') 
hold on
plot(f3,graf3_db,'r') 
hold on
plot(f4,graf4_db,'g') 
hold on
plot(f5,graf5_db,'m') 
xlim([0 30])
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)| [db]');
title('Señal EEG en el dominio de la frecuencia segun ancho de ventanas');
legend('Ventana largo L/10','Ventana largo L/50', 'Ventana largo L/100','Ventana largo L/200')

subplot(2,4,3)
plot(f2,graf2_db,'b') 
title('Espectro ventana largo L/10');
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)[db]|');
xlim([0 30])
subplot(2,4,4)
plot(f3,graf3_db,'r') 
title('Espectro ventana largo L/50');
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)[db]|');
xlim([0 30])
subplot(2,4,7)
plot(f4,graf4_db,'g') 
title('Espectro ventana largo L/100');
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)[db]|');
xlim([0 30])
subplot(2,4,8)
xlabel('Frecuencia [Hz]');ylabel('|EEG(f)[db]|');
plot(f5,graf5_db,'m') 
xlim([0 30])
title('Espectro ventana largo L/200');
ylabel('|EEG(f)[db]|');xlabel('Frecuencia [Hz]');