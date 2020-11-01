clear all
load('C:\Users\nafem\Documents\U\10 semestre\[IPD477] Bioingenieria\Datos-Tarea1\datos\ERP_data.mat');
M=length(EEGData);N=ep;signal=zeros(M,1);segments_vector=1:N;
Fs = 512;Ts = 1/Fs;                 % ms -> f=512[Hz]
t = double((0:M-1)*Ts);             % Time vector
f = ((0:M-1)*Fs)/(M); 
f2 = linspace(0,Fs,M/2); f3= linspace(0,Fs,M/10); f4= linspace(0,Fs,M/50);
metodo='Bartlett'; estimulo= 'auditivo';

number_segments=[1 4 10 50];
length_window=[M M/2 round(M/10) round(M/50)];
graf1=0;graf2=0; graf3=0;graf4=0;
prom_esp1=zeros(M,1);prom_esp2=zeros(M/2,1);prom_esp3=zeros(round(M/10),1);prom_esp4=zeros(round(M/50),1);
prom_esp1_db=zeros(M,1);prom_esp2_db=zeros(M/2,1);prom_esp3_db=zeros(round(M/10),1);prom_esp4_db=zeros(round(M/50),1);


for v=1:N
    signal=EEGSegments(:,v);
    for j=1:4
    %----------------variable para cada tipo de segmento----------------------%
    signal_segments=zeros(length_window(j),number_segments(j));
    signal_segments_fft=zeros(length_window(j),number_segments(j));
    pa_graficar=zeros(length_window(j),length(length_window));
    
        for i=1:number_segments(j)
            pos1 = ((i-1)*length_window(j)+1);
            pos2 = double(i*length_window(j));
            ancho= length_window(j);
            
            %-----separación de señal en distintos segmentos de largo M/j-----%
            if double(M)-double(pos2)<0
                signal_segments(:,i)=[signal(pos1:M);zeros(abs(double(length_window(j))-double(length(signal(pos1:M)))),1)];
            elseif double(M)-double(pos2)==0
                signal_segments(:,i)=signal(pos1:pos2);
            else
                signal_segments(:,i)=signal(((i-1)*length_window(j)+1):(i*length_window(j)));
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
                prom_esp1(:,1)=prom_esp1(:,1)+graf1;
                prom_esp1_db(:,1)=prom_esp1_db(:,1)+graf1_db;   

            case 2
                graf2=(double(pa_graficar(:,j))/double(number_segments(j)));
                graf2_db=20*log10(graf2);
                prom_esp2(:,1)=prom_esp2(:,1)+graf2; 
                prom_esp2_db(:,1)=prom_esp2_db(:,1)+graf2_db;  

            case 3
                graf3=(double(pa_graficar(:,j))/double(number_segments(j)));
                graf3_db=20*log10(graf3);
                prom_esp3(:,1)=prom_esp3(:,1)+graf3; 
                prom_esp3_db(:,1)=prom_esp3_db(:,1)+graf3_db;  

            case 4
                graf4=(double(pa_graficar(:,j))/double(number_segments(j)));
                graf4_db=20*log10(graf4);
                prom_esp4(:,1)=prom_esp4(:,1)+graf4; 
                prom_esp4_db(:,1)=prom_esp4_db(:,1)+graf4_db;  

            otherwise
        end
    end    
end
run('act2_figure_espectro_wintowin.m')
