clear all
% cargada de registros e inicialización de variables
load('C:\Users\nafem\Documents\U\10 semestre\[IPD477] Bioingenieria\Datos-Tarea1\datos\ERP_data.mat');
M=length(EEGData);N=ep; Fs = 512;
Ts = 1/Fs;                           % ms -> f=512[Hz]
t = double((0:M-1)*Ts);              % Time vector
segments_vector=1:N; rms_audio=0;
prom_sorted_audio=zeros(M,1);prom_weigthed_audio=zeros(M,1);prom_standar_audio=zeros(M,1);

%calculo de RMS de cada segmento
for i=1:N
    rms_audio(i,1)=rms(EEGSegments(:,i));
end
%Normalización de los RMS
for i=1:N
    rms_normalizada(i,1)=((rms_audio(i,1))/mean(rms_audio(:,1)));
end
[valor_posicion,posicion]=sort(rms_audio); %ordenamiento de RMS

%Suma de cada metodo de ponderación
 for i=1:N
     prom_sorted_audio(:,1)= prom_sorted_audio(:,1) + EEGSegments(:,posicion(i));
     prom_weigthed_audio(:,1)= prom_weigthed_audio(:,1) + (EEGSegments(:,i)/rms_normalizada(i,1));
     prom_standar_audio(:,1)= prom_standar_audio(:,1) + EEGSegments(:,i);  
 end

% inicialización de variables para selección de señal según método:
%          --- promedio por pesos ---             %
[max_signal_weigthed,i_max_signal_weigthed] = max(prom_weigthed_audio); % para obtener el Vpp
[min_signal_weigthed,i_min_signal_weigthed] = min(prom_weigthed_audio); % para obtener el Vpp
Vpp_weigthed=max_signal_weigthed - min_signal_weigthed;
largo_ventana_weigthed =i_max_signal_weigthed-i_min_signal_weigthed;
%          --- promedio clasico ---               %
[max_signal_standar,i_max_signal_standar] = max(prom_standar_audio); % para obtener el Vpp
[min_signal_standar,i_min_signal_standar] = min(prom_standar_audio); % para obtener el Vpp
Vpp_standar=max_signal_standar - min_signal_standar;
largo_ventana_standar =abs(i_max_signal_standar-i_min_signal_standar);
%          --- promedio ordena ---                %
[max_signal_sorted,i_max_signal_sorted] = max(prom_sorted_audio); % para obtener el Vpp
[min_signal_sorted,i_min_signal_sorted] = min(prom_sorted_audio); % para obtener el Vpp
Vpp_sorted=max_signal_sorted - min_signal_sorted;
largo_ventana_sorted =abs(i_max_signal_sorted-i_min_signal_sorted);

%Calculo de SNR para cada segmento según señal seleccionada.
for i = 1:N
    snr_weigthed=0;snr_sorted=0;snr_standar=0; j=1;
    indice_weigthed=1;indice_sorted=1;indice_standar=1;
    while indice_weigthed + largo_ventana_weigthed <= M  
        ruido_weigthed= max(EEGSegments(indice_weigthed:indice_weigthed+largo_ventana_weigthed,i))-min(EEGSegments(indice_weigthed:indice_weigthed+largo_ventana_weigthed,i));
        snr_weigthed(j)= 10*log10((Vpp_weigthed^2)/(Vpp_weigthed-ruido_weigthed)^2);
        j=j+1;
        indice_weigthed=indice_weigthed+largo_ventana_weigthed+1;
    end
    ruido_weigthed= max(EEGSegments(indice_weigthed:M,i))-min(EEGSegments(indice_weigthed:M,i));
    snr_weigthed(j)= 10*log10((Vpp_weigthed^2)/(Vpp_weigthed-ruido_weigthed)^2);
    snr_weigthed_prom(i)=mean(snr_weigthed);
    
    j=1;
    while indice_sorted + largo_ventana_sorted <= M  
        ruido_sorted= max(EEGSegments(indice_sorted:indice_sorted+largo_ventana_sorted,posicion(i)))-min(EEGSegments(indice_sorted:indice_sorted+largo_ventana_sorted,posicion(i)));
        snr_sorted(j)= 10*log10((Vpp_sorted^2)/(Vpp_sorted-ruido_sorted)^2);
        j=j+1;
        indice_sorted=indice_sorted+largo_ventana_sorted+1;
    end
    ruido_sorted = max(EEGSegments(indice_sorted:M,i))-min(EEGSegments(indice_sorted:M,i));
    snr_sorted(j)=10*log10((Vpp_sorted^2)/(Vpp_sorted-ruido_sorted)^2);
    snr_sorted_prom(i)= mean(snr_sorted);
    
    j=1;
    while indice_standar + largo_ventana_standar <= M  
        ruido_standar= max(EEGSegments(indice_standar:indice_standar+largo_ventana_standar,i))-min(EEGSegments(indice_standar:indice_standar+largo_ventana_standar,i));
        snr_standar(j)= 10*log10((Vpp_standar^2)/(Vpp_standar-ruido_standar)^2);
        j=j+1;
        indice_standar=indice_standar+largo_ventana_standar+1;
    end
    ruido_standar = max(EEGSegments(indice_standar:M,i))-min(EEGSegments(indice_standar:M,i));
    snr_standar(j)=10*log10((Vpp_standar^2)/(Vpp_standar-ruido_standar)^2);
    snr_standar_prom(i)= mean(snr_standar);
end

% division por muestra de cada promedio.
prom_sorted_audio=prom_sorted_audio/N;  prom_weigthed_audio= prom_weigthed_audio/N;
prom_standar_audio=prom_standar_audio/N;

run('act2_figure_audio_barsorted.m')
run('act2_figure_audio_timefreq.m')


