clc
clear

xx = massanervuras();
yy = massalongarina();
zz = asa_espessura_cte(1);

composito = ["ABS-","PLA-","PETG"];
dens_comp = [1.04 1.24 1.27];

fprintf('\n')
disp('ASA COMPLETA')
fprintf('Mat-  M-NACA12[g]  M-NACA_Var[g]\n')
for k=1:length(composito)
    MassaASA(k) = xx(k) + yy(k);
    MassaASAvar(k) = yy(k) + zz(k);
    fprintf('%s  %.4f     %.4f \n',composito(k),MassaASA(k),MassaASAvar(k));
end
