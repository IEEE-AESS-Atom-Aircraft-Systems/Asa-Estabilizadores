clc
clear

%Valores de Entrada
Cvtip = 0.0740764;  %[m] Corda da Ponta do Estabilizador Vertical
croot_v = 0.123461; %[m] Corda da Raiz do Estabilizador Vertical
croot_h = 0.123461; %[m] Corda da Raiz do Estabilizador Horizontal
L = 1.372;          %[m] comprimento da asa

%% ---------------------- ESTABILIZADOR HORIZONTAL ------------------------
L_est_h = L/4;       %[m] comprimento do estabilizador horizontal
u = linspace(0,1,600);
x = u.^2;
y = 5*0.12*(0.2969*u - 0.1260*u.^2 - 0.3516*u.^4 + 0.2843*u.^6 - 0.1015*u.^8);

%Calculo da Area da Nervura Normalizada
%Area de Riemann a Esquerda
for k=1:length(x)-1
    Ae(k) = y(k)*(x(k+1)-x(k));
end
AreaE = sum(Ae);
AreaNervuraNorm = 2*AreaE;

ANervEstabi_h = AreaNervuraNorm*(croot_h^2); %area [m2]
n_nerv_est_h = 3;
t_nerv_est_h = 0.005;  %espessura da nervura [m]
V_nerv_est_h = t_nerv_est_h * ANervEstabi_h; %[m3]

composito = ["ABS","PLA","PETG"];
dens_comp = [1.04 1.24 1.27];

%Massa para as nervuras do estabilizador horizontal
disp('NERVURAS ESTABILIZADOR HORIZONTAL')
fprintf('Mat   Massa [g]\n')
for k=1:length(dens_comp)
    MassaNerEstH(k) = 1e6* V_nerv_est_h * dens_comp(k) * n_nerv_est_h;
    fprintf('%s   %.4f\n',composito(k),MassaNerEstH(k));
end
    
%Massa da longarina do estabilizador horizontal
H_est_h = 0.12*croot_h;  %Altura da seção da longarina
B_est_h = 0.08*croot_h;  %Base da seção da longarina

Sec_Long_est_h = H_est_h * B_est_h;  %Area da seção da longarina
V_long_est_h = Sec_Long_est_h * L_est_h; %Volume da longarina

fprintf('\n')
disp('LONGARINA ESTABILIZADOR HORIZONTAL')
fprintf('Mat   Massa [g]\n')
for k=1:length(dens_comp)
    Massa_long_est_h(k) = 1e6* V_long_est_h * dens_comp(k);  %massa da longarina
    fprintf('%s   %.4f\n',composito(k),Massa_long_est_h(k));
end

fprintf('\n')
disp('MASSA ESTABILIZADOR HORIZONTAL')
fprintf('Mat   Massa [g]\n')
for k=1:length(dens_comp)
    Massa_est_h(k) = Massa_long_est_h(k) + MassaNerEstH(k);  %massa da longarina
    fprintf('%s   %.4f\n',composito(k),Massa_est_h(k));
end

%% ---------------------- ESTABILIZADOR VERTICAL --------------------------
n_nervuras = 3;
for i=1:n_nervuras
    cest_v(i) = (Cvtip - croot_v)*(i-1)/(n_nervuras-1) + croot_v;
end
for k1 = 1:n_nervuras
    ANervEstabi_v(k1) = AreaNervuraNorm*cest_v(k1)^2;
    %fprintf('%.4f      %.4f\n',cordas(k1),AreaNervura(k1))
end

%Nervura do estabilizador vertical
t_nerv_est_v = 0.005;  %espessura da nervura [m]
V_nerv_est_v = t_nerv_est_v * ANervEstabi_v; %[m3]
fprintf('\n')
disp('NERVURAS ESTABILIZADOR VERTICAL')
fprintf('Mat   Massa [g]\n')
for k=1:length(dens_comp)
    MassaNerEst_v(k) = 1e6 * sum(V_nerv_est_v) * dens_comp(k);  %massa de todas as nervuras
    fprintf('%s   %.4f\n',composito(k),MassaNerEst_v(k));
end

%Longarina do estabilizador vertical
L_est_v = 0.5*L_est_h;  %Longarina do estabilizador Vertical [m]
H_est_v = 0.12*Cvtip;   %Altura da seçao da longarina no estabilizador vertical [m]
B_est_v = 0.08*Cvtip;   %Base da seçao longarina no estabilizador vertical [m]
Sec_Long_est_v = H_est_v * B_est_v;  %Area da seção da longarina
V_long_est_v = Sec_Long_est_v * L_est_v; %Volume da longarina

fprintf('\n')
disp('LONGARINA ESTABILIZADOR VERTICAL')
fprintf('Mat   Massa [g]\n')
for k=1:length(dens_comp)
    Massa_long_est_v(k) = 1e6* V_long_est_v * dens_comp(k);  %massa da longarina
    fprintf('%s   %.4f\n',composito(k),Massa_long_est_v(k));
end

%Massa do estabilizador vertical
fprintf('\n')
disp('MASSA DOS 2 ESTABILIZADORES VERTICAIS')
fprintf('Mat   Massa [g]\n')
for k=1:length(dens_comp)
    Massa_est_v(k) = 2*(Massa_long_est_v(k) + MassaNerEst_v(k));  %massa da longarina
    fprintf('%s   %.4f\n',composito(k),Massa_est_v(k));
end
