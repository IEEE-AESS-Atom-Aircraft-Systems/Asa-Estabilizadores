clc
close all
clear all

M = '0.01';           %Mach
Re = '20000';         %Reynolds
AoA = '0';            %Angulo de Ataque
iter = '100';         %Iterações maximas no XFOIL

for k=1:100
kk = num2str(k);
fid = fopen(['entrada' kk '.txt'],'w');
fprintf(fid,['load Aerofolio' kk '.dat\n']);
fprintf(fid,'OPER\n');
fprintf(fid,'v\n\n');
fprintf(fid,['re ' Re '\n']);
fprintf(fid,['m ' M '\n']);
fprintf(fid,['iter ' iter '\n']);
fprintf(fid,['a ' AoA '\n']);
fprintf(fid,['CPWR CP' kk '.txt \n']);
fclose(fid);
end
for k=1:100
kkk = strcat('entrada',num2str(k),'.txt');
cmd = strcat('xfoil.exe < ',kkk);
[status,result] = system(cmd);
end


