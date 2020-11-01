fig1=figure; fig2=figure;
%------------------------------------%

figure(fig1)
sgtitle(['Espectro señal por método ' metodo ' estimulo ' estimulo])
subplot(2,4,1)
plot(f,prom_esp1/N,'b')
xlim([0 40])
ylabel('|Signal(f)|');xlabel('Frecuencia [Hz]');
title('ventana L')
subplot(2,4,2)
plot(f2,prom_esp2/N,'r')
xlim([0 40])
ylabel('|Signal(f)|');xlabel('Frecuencia [Hz]');
title('ventana L/2')
subplot(2,4,5)
plot(f3,prom_esp3/N,'g')
xlim([0 40]);
ylabel('|Signal(f)|');xlabel('Frecuencia [Hz]');
title('ventana L/10')
subplot(2,4,6)
plot(f4,prom_esp4/N,'m')
xlim([0 80]);
ylabel('|Signal(f)|');xlabel('Frecuencia [Hz]');
title('ventana L/50')
subplot(2,4,[3 4,7 8])
plot(f,prom_esp1/N,'b')
hold on
plot(f2,prom_esp2/N,'r')
hold on
plot(f3,prom_esp3/N,'g')
hold on
plot(f4,prom_esp4/N,'m')
xlim([0 40]);
ylabel('|Signal(f)|');xlabel('Frecuencia [Hz]');

legend('Ventana L','Ventana L/2','Ventana L/10','Ventana L/50')

figure(fig2)
sgtitle(['Espectro señal por método ' metodo ' estimulo ' estimulo])
subplot(2,4,1)
plot(f,prom_esp1_db/N,'b')
xlim([0 80])
ylabel('|Signal(f)| [db]');xlabel('Frecuencia [Hz]');
title('ventana L')
subplot(2,4,2)
plot(f2,prom_esp2_db/N,'r')
xlim([0 80])
ylabel('|Signal(f)| [db]');xlabel('Frecuencia [Hz]');
title('ventana L/2')
subplot(2,4,5)
plot(f3,prom_esp3_db/N,'g')
xlim([0 80]);
ylabel('|Signal(f)| [db]');xlabel('Frecuencia [Hz]');
title('ventana L/10')
subplot(2,4,6)
plot(f4,prom_esp4_db/N,'m')
xlim([0 80]);
ylabel('|Signal(f)| [db]');xlabel('Frecuencia [Hz]');
title('ventana L/50')
subplot(2,4,[3 4,7 8])
plot(f,prom_esp1_db/N,'b')
hold on
plot(f2,prom_esp2_db/N,'r')
hold on
plot(f3,prom_esp3_db/N,'g')
hold on
plot(f4,prom_esp4_db/N,'m')
xlim([0 80]);
ylabel('|Signal(f)| [db]');xlabel('Frecuencia [Hz]');
legend('Ventana L','Ventana L/2','Ventana L/10','Ventana L/50')

