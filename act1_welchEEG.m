clear all
load('C:\Users\nafem\Documents\U\10 semestre\[IPD477] Bioingenieria\Datos-Tarea1\datos\OngoingEEG_data.mat');
%-------------------------Configuración inicial---------------------------%
Fs= samplingRate;
Ts= 1/Fs;                   % Sampling period       
L = EEGPoints;              % Length of signal
t = double((0:L-1)*Ts);     % Time vector
f = ((0:L-1)*Fs)/(L);       % Frequency vector
f2= linspace(0,1024,L/10); f3= linspace(0,1024,L/50); f4= linspace(0,1024,L/100); f5= linspace(0,1024,L/200);

number_segments=[1 10 50 100 200];
length_window=[L L/10 L/50 L/100 L/200];
graf1=0;graf2=0; graf3=0;graf4=0;graf5=0;
graf1_db=0;graf2_db=0; graf3_db=0;graf4_db=0;graf5_db=0;
duty_cicle=4/3;


for j=1:length(length_window)
    if length_window(j)==double(L)
        graf1=fourier(EEGData);
        graf1_db=20*log10(graf1);
    else
        signal_segments=zeros(length_window(j),number_segments(j));
        posicion_ventana=[1;double(length_window(j))];
        for i=1:10000
            posicion_ventana(2)=cuadratura(posicion_ventana(1),posicion_ventana(2),L,double(length_window(j)));
            if ((double(L)-double(posicion_ventana(2)<0))&&(length(posicion_ventana(1):posicion_ventana(2))== double(length_window(j)))&&(posicion_ventana(2)<L))
                signal_segments(:,i)=EEGData(posicion_ventana(1):posicion_ventana(2));
                posicion_ventana(1)=(posicion_ventana(2)-(fix((double(length_window(j))/duty_cicle)*10)/10)+1);
                posicion_ventana(2)=(i+1)*length_window(j)-(i*(fix((double(length_window(j))/duty_cicle)*10)/10));
            elseif((double(posicion_ventana(2))+double(length_window(j))>double(L)))
                signal_segments(:,i)=[EEGData(posicion_ventana(1):double(L));zeros(double(length_window(j))-length(EEGData(posicion_ventana(1):double(L))),1)];
                break
            else
            end
        end
        graf=fourier(signal_segments);
        
        switch j
            case 2
                graf2=graf;
                graf2_db=20*log10(graf2);
            case 3
                graf3=graf;
                graf3_db=20*log10(graf3);
            case 4
                graf4=graf;
                graf4_db=20*log10(graf4);
            otherwise
                graf5=graf;
                graf5_db=20*log10(graf5);
        end
    end
end

run('act1_figure')

%función para sobreponer cada ventana através del movimento de los indices
%sin que sobre pasen el largo máximo
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

%función para obtener el espectro promedio.
function graf = fourier(dato)
    graf=zeros(length(dato),1);
    for i=1:length(dato(1,:))
        graf(:,1)=(graf(:,1)+abs(fft(dato(:,i))));         
    end
    graf=graf/length(dato(1,:));
end



