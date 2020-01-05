N=50; % numarul de coeficienti
P=40; % perioada                                                       
D=4; % durata de crestere                                                        
w0=2*pi/P; % pulsatie
t_1=0:0.02:D; % esantionarea semnalului initial

% generam semnalul triunghiular initial
x_1= sawtooth((pi/2)*t_1,0.5)/2+0.5; 
t=0:0.02:P; % esantionarea semnalului reconstruit
x = zeros(1,length(t)); % initializarea vectorului x cu toate elementele 0
x(t<=D)=x_1; % vom inlocui toate valorile nule cu cele din semnalul initial cu conditia t<=D

figure(1);
plot(t,x);% afisam semnalului x(t)
title('x(t)(linie solida) si reconstruirea (linie punctata)');
hold on;

% m este variabilia dupa care se face suma
for m = -N:N
    x_t = x_1; %x_t este semnalul realizat cu formula SF
    x_t = x_t .* exp(-j*m*w0*t_1); % vectorul ce trebuie integrat
    X(m+N+1)=0;% initializarea 

    for i = 1: length(t_1)-1
        X(m+N+1) = X(m+N+1) + (t_1(i+1)-t_1(i))* (x_t(i)+x_t(i+1))/2; % vom integra folosindu-ne de metoda dreptunghiurilor
    end
end

for i = 1: length(t)
    x_reconstruit(i) = 0;% initializarea elementelor vectorului reconstruit
    for m=-N:N
        x_reconstruit(i) = x_reconstruit(i) + (1/P)*X(m+N+1)*exp(j*m*w0*t(i));% calculam suma
    end
end

plot(t,x_reconstruit,'--');% afisarea semnalului reconstruit cu linie punctata pe acelasi grafic cu primul semnal
figure(2);

w=-50:50;% generarea vectorului de pulsatii corespunzatoare coeficientilor Xm
stem(w,abs(X));% afisarea spectrului de amplitudini
title('Spectrul de amplitudini al semnalului')


% Orice semnal periodic poate fi descris de o suma de cos si sin, inmultite
% cu coeficienti corespunzatori.Coeficientii acestia constituie spectrul.
% Semnalul reconstruit se apropie de forma primului semnal, avand o
% marja de eroare din cauza din cauza faptului ca am folosit un numar finit de coeficienti( in
% cazul de fata 50). Pe masura ce folosim mai multi coeficienti ai seriei
% Fourier, semnalul reconstruit se va apropia din ce in ce mai mult de
% semnalul initial.