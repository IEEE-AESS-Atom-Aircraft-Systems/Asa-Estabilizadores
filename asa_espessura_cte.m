function xx = asa_espessura_cte(p)
%Definicao do contorno

c_t = 10.42;   %[cm]
c_r = 25.86;   %[cm]
n_nervuras = 10;
for i=1:n_nervuras
    cordas(i) = (c_r - c_t)*(i-1)/(n_nervuras-1) + c_t;
    alfa(i) = 0.12*c_r/cordas(i);
end

for i=1:n_nervuras
u = linspace(0,1,50);
x = u.^2;
y(i,:) = 5*alfa(i)*(0.2969*u - 0.1260*u.^2 - 0.3516*u.^4 + 0.2843*u.^6 - 0.1015*u.^8);
Areas(i) = (cordas(i))^2 * Riemann(x,y(i,:));
end

%%
%Materiais do Projeto
fprintf('\n')
disp('NACA VARIADO')
composito = ["ABS","PLA","PETG"];
dens_comp = [1.04 1.24 1.27];

t_nervuras = 0.5;  %espessura da nervura [cm]
%fprintf('\n')
fprintf('Mat   Massa [g]\n')
for k=1:length(dens_comp)
    MassaNervuraTodos(k) = sum(Areas)*t_nervuras*dens_comp(k);
    fprintf('%s   %.4f\n',composito(k),MassaNervuraTodos(k));
end

xx = MassaNervuraTodos;

if p == 1
    % ------------------- Grafico -------------------
    z = ones(length(x),1);
    %Formato da asa
    %Retangular = 1, Trapezoidal=2
    Fda = 2;
    L = 68.6;
    h = L/(n_nervuras-1);
    for n=1:n_nervuras
        hold on
        plot3(cordas(n)*(x-1),h*(n-1)*z,cordas(n)*y(n,:),'k','LineWidth',1.5)
        plot3(cordas(n)*(x-1),h*(n-1)*z,-cordas(n)*y(n,:),'r','LineWidth',1.5)
        %xspan_bf(n) = max(fat*xnc);
    end
    axis('equal')
    grid on
    xlabel('x/c')
    view(3)
end
end
