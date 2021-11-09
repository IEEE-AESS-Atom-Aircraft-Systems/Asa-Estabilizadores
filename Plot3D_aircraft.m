clc
clear 
close all

%Valores de Entrada         %[Unidade] -------- Descrição -------
Cvtip = 7.40764;            %[cm] Corda da Ponta do Estabilizador Vertical
croot_v = 12.3461;          %[cm] Corda da Raiz do Estabilizador Vertical
croot_h = 12.3461;          %[cm] Corda da Raiz do Estabilizador Horizontal
L = 137.2;                  %[cm] comprimento da envergadura
L_asa = L/2;                %[cm] comprimento da semi-asa
L_est_h = L/4;              %[cm] comprimento do estabilizador horizontal ---- (valor chutado)
L_est_v = 0.3*L_est_h;      %[cm] comprimento do estabilizador vertical ---- (valor chutado)
c_t = 10.42;                %[cm] Corda na ponta da Asa
c_r = 25.86;                %[cm] Corda na raiz da Asa
dist_asa_est = 40;          %[cm] Distância asa - estabilizador
%% ---------------------- ESTABILIZADOR HORIZONTAL ------------------------
u = linspace(0,1,600);
x = u.^2;
y = 5*0.12*(0.2969*u - 0.1260*u.^2 - 0.3516*u.^4 + 0.2843*u.^6 - 0.1015*u.^8);
n_nerv_est_h = 50;          %Numero de Nervuras Estabilizador Horizontal

% ---------------------------- Grafico ---------------------------------
z_est_h = ones(length(x),1);            
h = L_est_h/(n_nerv_est_h-1);       %espaço entre as nervuras

for n=1:n_nerv_est_h
    hold on
    plot3(-croot_h*(x-max(x)),h*(n-1)*z_est_h,croot_h*y,'k','LineWidth',1.5)
    plot3(-croot_h*(x-max(x)),h*(n-1)*z_est_h,-croot_h*y,'k','LineWidth',1.5)
end
plot3([0,0],[0,L_est_h],[0,0],'k','LineWidth',1.5)
plot3([croot_h*max(x),croot_h*max(x)],[0,L_est_h],[0,0],'k','LineWidth',1.5)
axis('equal')
view(3)

%% ---------------------- ESTABILIZADOR VERTICAL --------------------------
n_nerv_est_v = 30;          %Numero de Nervuras Estabilizador Vertical
for i=1:n_nerv_est_v
    cest_v(i) = (Cvtip - croot_v)*(i-1)/(n_nerv_est_v-1) + croot_v;
end

% ----------------------------- Grafico -----------------------------------
z = ones(length(x),1);
h = L_est_v/(n_nerv_est_v-1);

for n=1:n_nerv_est_v
    hold on
    %estabilizador direito
    plot3(-cest_v(n)*(x-max(x)),-0.12*max(y)+cest_v(n)*y,h*(n-1)*z-0.12*max(y),'k','LineWidth',1.5)
    plot3(-cest_v(n)*(x-max(x)),-0.12*max(y)-cest_v(n)*y,h*(n-1)*z-0.12*max(y),'k','LineWidth',1.5)
    %estabilizador esquerdo
    plot3(-cest_v(n)*(x-max(x)),L_est_h+0.12*max(y)+cest_v(n)*y,h*(n-1)*z-0.12*max(y),'k','LineWidth',1.5)
    plot3(-cest_v(n)*(x-max(x)),L_est_h+0.12*max(y)-cest_v(n)*y,h*(n-1)*z-0.12*max(y),'k','LineWidth',1.5)
end

%Linhas do estabilizador direito
plot3([0,0],[-0.12*max(y),-0.12*max(y)],[-0.12*max(y),L_est_v-0.12*max(y)],'k','LineWidth',1.5);
plot3([0.12*max(x),min(cest_v)*max(x)],[-0.12*max(y),-0.12*max(y)],[-0.12*max(y),L_est_v-0.12*max(y)],'k','LineWidth',1.5);
%Linhas do estabilizador esquerdo
plot3([0,0],[L_est_h+0.12*max(y),L_est_h+0.12*max(y)],[-0.12*max(y),L_est_v-0.12*max(y)],'k','LineWidth',1.5);
plot3([0.12*max(x),min(cest_v)*max(x)],[L_est_h+0.12*max(y),L_est_h+0.12*max(y)],[-0.12*max(y),L_est_v-0.12*max(y)],'k','LineWidth',1.5);

%% ------------------------------ ASA -------------------------------------
n_nervuras = 70;                %Numero de Nervuras da Asa
for i=1:n_nervuras
    cordas(i) = (c_t - c_r)*(i-1)/(n_nervuras-1) + c_r;
    alfa(i) = 0.12*c_r/cordas(i);
    uw = linspace(0,1,100);
    xw = uw.^2;
    yw(i,:) = 5*alfa(i)*(0.2969*uw - 0.1260*uw.^2 - 0.3516*uw.^4 + 0.2843*uw.^6 - 0.1015*uw.^8);
end

% ----------------------------- GRAFICO -----------------------------------
zw = ones(1,length(xw));
h = L_asa/(n_nervuras-1);
%------------------------------ASA DIREITA---------------------------------
for n=1:n_nervuras
    hold on
    if n==1 || n==n_nervuras
        plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,-h*(n-1)*zw,cordas(n)*yw(n,:),'k','LineWidth',1.5)
        plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,-h*(n-1)*zw,-cordas(n)*yw(n,:),'k','LineWidth',1.5)
    else
        plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,-h*(n-1)*zw,cordas(n)*yw(n,:),'k','LineWidth',1.5)
        plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,-h*(n-1)*zw,-cordas(n)*yw(n,:),'k','LineWidth',1.5)
    end
end
%-------------------------------ASA ESQUERDA-------------------------------
for n=1:n_nervuras
    hold on
    if n==1 || n==n_nervuras
    plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,h*(n-1)*zw+L_est_h,cordas(n)*yw(n,:),'k','LineWidth',1.5)
    plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,h*(n-1)*zw+L_est_h,-cordas(n)*yw(n,:),'k','LineWidth',1.5)
    else
    plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,h*(n-1)*zw+L_est_h,cordas(n)*yw(n,:),'k','LineWidth',1.5)
    plot3(-cordas(n)*(xw-max(xw))+dist_asa_est,h*(n-1)*zw+L_est_h,-cordas(n)*yw(n,:),'k','LineWidth',1.5)   
    end
end
axis('equal')
grid on
xlabel('x')
view(3)