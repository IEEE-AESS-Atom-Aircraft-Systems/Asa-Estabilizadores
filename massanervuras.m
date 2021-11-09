function xx= massanervuras()
% clc
% clear all
% close all

%Definicao do contorno
c_t = 10.42;   %[cm]
c_r = 25.86;   %[cm]
n_nervuras = 6;
for i=1:n_nervuras
    cordas(i) = (c_t - c_r)*(i-1)/(n_nervuras-1) + c_r;
end
%cordas = linspace(0.6,1,5);

u = linspace(0,1,600);
x = u.^2;
y = 5*0.12*(0.2969*u - 0.1260*u.^2 - 0.3516*u.^4 + 0.2843*u.^6 - 0.1015*u.^8);

%Calculo da Area do Aerofólio
%Area de Riemann a Direita
for k=1:length(x)-1
    Ad(k) = y(k+1)*(x(k+1)-x(k));
end
AreaD = sum(Ad);
%Area de Riemann a Esquerda
for k=1:length(x)-1
    Ae(k) = y(k)*(x(k+1)-x(k));
end
AreaE = sum(Ae);
AreaNervuraNorm = AreaE+AreaD;

disp('NERVURAS 0012')
%fprintf('Corda[cm]   Area [cm2]\n')
for k1 = 1:n_nervuras
    AreaNervura(k1) = AreaNervuraNorm*cordas(k1)^2;
    %fprintf('%.4f      %.4f\n',cordas(k1),AreaNervura(k1))
end

%Materiais do Projeto
composito = ["ABS","PLA","PETG"];
dens_comp = [1.04 1.24 1.27];

ID_comp = 4;  %Escolha do material para a asa (id >= 4 faz o calculo para todas)
t_nervuras = 0.5;  %espessura da nervura [cm]
%fprintf('\n')
if ID_comp == 1
    Massa_Nerv_ABS = sum(AreaNervura)*t_nervuras*dens_comp(1)
elseif ID_comp == 2
    Massa_Nerv_PLA = sum(AreaNervura)*t_nervuras*dens_comp(2)
elseif ID_comp == 3
    Massa_Nerv_PETG = sum(AreaNervura)*t_nervuras*dens_comp(3)
else
    fprintf('Mat   Massa [g]\n')
    for k=1:length(composito)
        MassaNervuraTodos(k) = sum(AreaNervura)*t_nervuras*dens_comp(k);
        fprintf('%s   %.4f\n',composito(k),MassaNervuraTodos(k));
    end
end
xx = MassaNervuraTodos;
end
