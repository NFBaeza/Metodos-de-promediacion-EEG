fig3=figure;

figure(fig3)
sgtitle('Espectro tiempo-frecuencia de registro auditivo')
subplot(3,1,1)
spectrogram(prom_standar_audio,N,0,N,Fs)
title('Espectro ponderacion clasica')
subplot(3,1,2)
spectrogram(prom_weigthed_audio,N,0,N,Fs)
title('Espectro ponderacion por muestras ponderada')
subplot(3,1,3)
spectrogram(prom_sorted_audio,N,0,N,Fs)
title('Espectro ponderacion ordenada')
