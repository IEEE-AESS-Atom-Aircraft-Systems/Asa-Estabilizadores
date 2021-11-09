function xx = massalongarina()

%Codigo para massa da Longarina
%c_t = 10.42;   %[cm]
%c_r = 25.86;   %[cm]

H = 1;          %[cm]
B = 0.8;        %[cm]
L = 137.2/2;    %[cm]
area_sec = B*H;
Vol_long = L*area_sec;

%Materiais do Projeto
composito = ["ABS","PLA","PETG"];
dens_comp = [1.04 1.24 1.27];

fprintf('\n')
disp('LONGARINAS')
fprintf('Mat   Massa [g]\n')
    for k=1:length(composito)
        MassaLongarina(k) = Vol_long*dens_comp(k);
        fprintf('%s   %.4f\n',composito(k),MassaLongarina(k));
    end
xx = MassaLongarina;
end
