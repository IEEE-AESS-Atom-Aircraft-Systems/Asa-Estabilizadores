clc
clear all
close all

c_t = 10.42;   %[cm]
c_r = 25.86;   %[cm]
n_nervuras = 100;
for i=1:n_nervuras
    cordas(i) = (c_r - c_t)*(i-1)/(n_nervuras-1) + c_t;
    alfa(i) = 0.12*c_r/cordas(i);
end

%Definicao do contorno
for i=1:n_nervuras
u = linspace(0,1,60);
x = u.^2;
y(i,:) = 5*alfa(i)*(0.2969*u - 0.1260*u.^2 - 0.3516*u.^4 + 0.2843*u.^6 - 0.1015*u.^8);
end

for p=1:n_nervuras
    NumAero = num2str(p);
    nome = ['Aerofolio' NumAero];
    fid = fopen([nome,'.dat'],'w');
    fprintf(fid,"NACA%d \n", p);
    for k=1:length(x)
        fprintf(fid,'%f %f\n',x(1,length(x)-k+1),y(p,length(x)-k+1));
    end
    for kk = 1:length(x)
        fprintf(fid,'%f %f\n',x(1,kk),-y(p,kk));
    end
    fclose(fid);
end
