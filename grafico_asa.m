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

% figure(1)
% hold on
% plot(x,y(1,:),'k');
% plot(x,-y(1,:),'k');
% xlabel('x/c')
% hold off
% axis equal;
% grid on

%%
Pressao = GeradorPressao();
figure(2)
L = 68.6;
h = L/(n_nervuras-1);
z = ones(1,length(x));
[cmap_up,cmap_lo] = GeradorPressao();
colormap(turbo);
for n=1:n_nervuras
surface(cordas(n)*[(x-max(x));(x-max(x))],h*(n-1)*[z;z],cordas(n)*[y(n,:);y(n,:)],[fliplr(cmap_up(n,:));fliplr(cmap_up(n,:))],'FaceColor','none','EdgeColor','interp','LineWidth',3);
surface(cordas(n)*[(x-max(x));(x-max(x))],h*(n-1)*[z;z],-cordas(n)*[y(n,:);y(n,:)],[cmap_lo(n,:);cmap_lo(n,:)],'FaceColor','none','EdgeColor','interp','LineWidth',2);
end
colorbar;
title('Coeficiente de Pressão para \alpha = 0º, Re = 2e5, M = 0.01 ')
axis('equal')
grid on
xlabel('x [cm]')
view(3)


%REFERÊNCIAS
%https://stackoverflow.com/questions/45556001/how-to-create-a-color-gradient-using-a-third-variable-in-matlab/45556308
%https://www.mathworks.com/help/matlab/math/array-indexing.html
%https://www.mathworks.com/help/wavelet/ref/wrev.html






