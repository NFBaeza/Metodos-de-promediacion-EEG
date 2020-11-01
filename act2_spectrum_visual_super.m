clear all
load('C:\Users\nafem\Documents\U\10 semestre\[IPD477] Bioingenieria\Datos-Tarea1\datos\SSVEP_data.mat');
M=length(EEGData);N=ep; signal=zeros(M,1);segments_vector=1:N;
Fs = 256; Ts = 1/Fs;                % ms -> f=256[Hz]
t = double((0:M-1)*Ts);             % Time vector
f = ((0:M-1)*Fs)/(M); 
f2 = linspace(0,Fs,M/2); f3= linspace(0,Fs,M/10); f4= linspace(0,Fs,round(M/50));
metodo='Welch';estimulo='visual';

number_segments=[1 4 10 50];
length_window=[M M/2 round(M/10) round(M/50)];
prom_esp1=zeros(M,1);prom_esp2=zeros(M/2,1);prom_esp3=zeros(round(M/10),1);prom_esp4=zeros(round(M/50),1);
prom_esp1_db=zeros(M,1);prom_esp2_db=zeros(M/2,1);prom_esp3_db=zeros(round(M/10),1);prom_esp4_db=zeros(round(M/50),1);
duty_cicle=2;% modificar este valor para distintos DC, 
%pero está definido como L*(1/DC)<}-> 2=50% , 4/3->75% , 4->25%

for v=1:N
    signal=EEGSegments(:,v);
    for j=1:4
    if length_window(j)==double(M)
        prom_esp1=prom_esp1+fourier(signal);
        prom_esp1_db=prom_esp1_db+20*log10(prom_esp1);
    else
        signal_segments=zeros(length_window(j),number_segments(j));
        posicion_ventana=[1;double(length_window(j))];
        for i=1:10000
            posicion_ventana(2)=cuadratura(posicion_ventana(1),posicion_ventana(2),M,double(length_window(j)));
            if ((double(M)-double(posicion_ventana(2)<0))&&(length(posicion_ventana(1):posicion_ventana(2))== double(length_window(j)))&&(posicion_ventana(2)<M))
                signal_segments(:,i)=signal(posicion_ventana(1):posicion_ventana(2));
                posicion_ventana(1)=round((posicion_ventana(2)-(fix((double(length_window(j))/duty_cicle)*10)/10)+1));
                posicion_ventana(2)=round((i+1)*length_window(j)-(i*(fix((double(length_window(j))/duty_cicle)*10)/10)));
            elseif((double(posicion_ventana(2))+double(length_window(j))>double(M)))
                signal_segments(:,i)=[signal(posicion_ventana(1):double(M));zeros(double(length_window(j))-length(signal(posicion_ventana(1):double(M))),1)];
                break
            else
            end
        end
        
        grafx=fourier(signal_segments);
        
       switch j             
            case 2
                prom_esp2_db=prom_esp2_db+20*log10(grafx);
                prom_esp2=prom_esp2+(grafx);
            case 3
                prom_esp3_db=prom_esp3_db+20*log10(grafx);
                prom_esp3=prom_esp3+(grafx); 
            case 4
                prom_esp4_db=prom_esp4_db+20*log10(grafx);
                prom_esp4=prom_esp4+(grafx); 
            otherwise
        end
    end
    end
end

run('act2_figure_espectro_wintowin')

function y = cuadratura(pos1,pos2,largo_total, largo_ventana)
    if ((length(pos1:pos2)>largo_ventana)&&(pos2<largo_total))
        y=pos2-(double(length(pos1:pos2))-double(largo_ventana));       
    elseif (((length(pos1:pos2))<double(largo_ventana))&&(double(pos2)<largo_total))
        y=pos2+(double(largo_ventana)-double(length(pos1:pos2)));          
    elseif (pos2>=largo_total)
        y=largo_total;
    else
        y=pos2;
    end
end

function graf = fourier(dato)
    graf=zeros(length(dato(:,1)),1);
    for i=1:length((dato(1,:)))
        graf(:,1)=(graf(:,1)+abs(fft(dato(:,i))));         
    end
    graf=graf/length(dato(1,:));
end



