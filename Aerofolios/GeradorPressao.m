function [CpUpper,CpLower] = GeradorPressao()

for k=1:100
nome_arquivo = strcat('CP',num2str(k),'.txt');
cp = importdata(nome_arquivo,' ',3);
MatrizCp(k,:) = cp.data(:,3)';
end

CpUpper = MatrizCp(:,(1:60));
CpLower = MatrizCp(:,(60:end));
end
