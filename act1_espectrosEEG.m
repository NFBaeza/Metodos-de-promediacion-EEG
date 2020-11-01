clear all
load('C:\Users\nafem\Documents\U\10 semestre\[IPD477] Bioingenieria\Datos-Tarea1\datos\OngoingEEG_data.mat');
%-------------------------Configuración inicial---------------------------%
Fs= samplingRate;
Ts= 1/Fs;                   % Sampling period       
L = EEGPoints;              % Length of signal
t = double((0:L-1)*Ts);     % Time vector
f = ((0:L-1)*Fs)/(L);       % Frequency vector
f2= linspace(0,1024,L/10); f3= linspace(0,1024,L/50); f4= linspace(0,1024,L/100); f5= linspace(0,1024,L/200);

number_segments=[1 10 50 100 200]; length_window=[L L/10 L/50 L/100 L/200];
graf1=0;graf2=0; graf3=0;graf4=0;graf5=0;

%------Segmentación de señal según largo de ventanas rectangulares--------%
for j=1:5
%----------------variable para cada tipo de segmento----------------------%
signal_segments=zeros(length_window(j),number_segments(j));
signal_segments_fft=zeros(length_window(j),number_segments(j));
pa_graficar=zeros(length_window(j),length(length_window));
    for i=1:number_segments(j)
        %-----separación de señal en distintos segmentos de largo L/j-----%
        if double(L)-double(i*length_window(j))<0
            signal_segments(:,i)=[EEGData(((i-1)*length_window(j)+1):L);zeros(abs(double(L)-double(i*length_window(j))),1)];
        else
            signal_segments(:,i)=EEGData(((i-1)*length_window(j)+1):(i*length_window(j)));
        end
    end
    for i=1:number_segments(j)
        %--------------------fft de cada segmento-------------------------%
        signal_segments_fft(:,i)=abs(fft(signal_segments(:,i)));
        pa_graficar(:,j)=(pa_graficar(:,j)+signal_segments_fft(:,i));         
    end
    
    %-----------separación de espectros de cada ventana-------------------%
    switch j
        case 1
            graf1=(double(pa_graficar(:,j)));
            graf1_db=20*log10(graf1);
        case 2
            graf2=(double(pa_graficar(:,j))/double(number_segments(j)));
            graf2_db=20*log10(graf2);
        case 3
            graf3=(double(pa_graficar(:,j))/double(number_segments(j)));
            graf3_db=20*log10(graf3);
        case 4
            graf4=(double(pa_graficar(:,j))/double(number_segments(j)));
            graf4_db=20*log10(graf4);
        otherwise
            graf5=(double(pa_graficar(:,j))/double(number_segments(j)));
            graf5_db=20*log10(graf5);
    end
end

%------------------Script de configuración de gráficos--------------------%
run('act1_figure.m')