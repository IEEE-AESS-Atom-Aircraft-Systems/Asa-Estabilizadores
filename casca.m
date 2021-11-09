clc
clear
c_t = 10.42;   %[cm]
c_r = 25.86;   %[cm]

n_nervuras = 1000;
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

for j = 1:n_nervuras
    for k=1:length(x)-1
        dx(k) = cordas(j)*(x(k+1)-x(k));
        dy(k) = cordas(j)*(y(j,k+1)-y(j,k));
        ds(j,k) = sqrt(dx(k)^2 + dy(k)^2);
    end
    comp_aero(j) = sum(ds(j,:));
end

L = 137.2/2;

for k = 1:length(comp_aero)-1
    area_casca(k) = (comp_aero(k+1)+comp_aero(k))*(L/(2*(length(comp_aero)-1)));
end

area_trap = (c_t + c_r)*L/2;
area = sum(area_casca);
espe_casca = 0.2;
volume_casca = area*espe_casca;

fprintf('Area da Asa Trapezoidal: %.4f [cm2]\n',area_trap)
fprintf('Area Molhada da Asa Trapezoidal: %.4f [cm2]\n\n',2*area)
%Materiais do Projeto
composito = ["ABS-","PLA-","PETG"];
dens_comp = [1.04 1.24 1.27];

disp('MASSA DA CASCA')
fprintf('Mat   Massa [g]\n')
for k=1:length(composito)
    massa_casca(k) = volume_casca*dens_comp(k);
    fprintf('%s  %.4f\n',composito(k),2*massa_casca(k));
end
