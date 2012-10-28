function [out] = cad_glcm_features(glcm)

% VECTORIZED CODE: FASTER

size_glcm_1 = size(glcm,1); 
size_glcm_2 = size(glcm,2); 
size_glcm_3 = size(glcm,3);

% checked 
out.autoc = zeros(1,size_glcm_3); % Autocorrelation: [2] 
out.contr = zeros(1,size_glcm_3); % Contrast: matlab/[1,2] 
out.corrm = zeros(1,size_glcm_3); % Correlation: matlab 
out.corrp = zeros(1,size_glcm_3); % Correlation: [1,2] 
out.cprom = zeros(1,size_glcm_3); % Cluster Prominence: [2] 
out.cshad = zeros(1,size_glcm_3); % Cluster Shade: [2] 
out.dissi = zeros(1,size_glcm_3); % Dissimilarity: [2] 
out.energ = zeros(1,size_glcm_3); % Energy: matlab / [1,2] 
out.entro = zeros(1,size_glcm_3); % Entropy: [2] 
out.homom = zeros(1,size_glcm_3); % Homogeneity: matlab 
out.homop = zeros(1,size_glcm_3); % Homogeneity: [2] 
out.maxpr = zeros(1,size_glcm_3); % Maximum probability: [2] 
out.sosvh = zeros(1,size_glcm_3); % Sum of sqaures: Variance [1] 
out.savgh = zeros(1,size_glcm_3); % Sum average [1] 
out.svarh = zeros(1,size_glcm_3); % Sum variance [1] 
out.senth = zeros(1,size_glcm_3); % Sum entropy [1] 
out.dvarh = zeros(1,size_glcm_3); % Difference variance [4] 
out.denth = zeros(1,size_glcm_3); % Difference entropy [1] 
out.inf1h = zeros(1,size_glcm_3); % Information measure of correlation1 [1] 
out.inf2h = zeros(1,size_glcm_3); % Informaiton measure of correlation2 [1] 
out.indnc = zeros(1,size_glcm_3); % Inverse difference normalized (INN) [3] 
out.idmnc = zeros(1,size_glcm_3); % Inverse difference moment normalized [3]

% Indices 
[i,j] = meshgrid(1:size_glcm_1,1:size_glcm_2); 
idx1 = (i+j)-1; 
idx2 = abs(i-j)+1; 
ii = (1:(2*size_glcm_1-1))'; 
jj = (0:size_glcm_1-1)';

for k = 1:size_glcm_3 % number glcms 
% Normalize GLCM 
glcm_sum = sum(sum(glcm(:,:,k))); 
Pij = glcm(:,:,k)./glcm_sum; % Normalize each glcm 
glcm_mean = mean(Pij(:)); % compute mean after norm 
% 
p_x = squeeze(sum(Pij,2)); 
p_y = squeeze(sum(Pij,1))'; 
% 
u_x = sum(sum(i.*Pij)); 
u_y = sum(sum(j.*Pij)); 
% 
p_xplusy = zeros((2*size_glcm_1 - 1),1); %[1] 
p_xminusy = zeros((size_glcm_1),1); %[1] 
for aux = 1:max(idx1(:)) 
p_xplusy(aux) = sum(Pij(idx1==aux)); 
end 
for aux = 1:max(idx2(:)) 
p_xminusy(aux) = sum(Pij(idx2==aux)); 
end 

% Contrast 
out.contr(k) = sum(sum((abs(i-j).^2).*Pij)); 
% Dissimilarity 
out.dissi(k) = sum(sum(abs(i-j).*Pij)); 
% Energy 
out.energ(k) = sum(sum(Pij.^2)); 
% Entropy 
out.entro(k) = -sum(sum(Pij.*log(Pij+eps))); 
% Homogeneity Matlab 
out.homom(k) = sum(sum(Pij./(1+abs(i-j)))); 
% Homogeneity Paper 
out.homop(k) = sum(sum(Pij./(1+abs(i-j).^2))); 
% Sum of squares: Variance 
out.sosvh(k) = sum(sum(Pij.*((j-glcm_mean).^2))); 
% Inverse difference normalized 
out.indnc(k) = sum(sum(Pij./(1+(abs(i-j)./size_glcm_1)))); 
% Inverse difference moment normalized 
out.idmnc(k) = sum(sum(Pij./(1+((i-j)./size_glcm_1).^2))); 
% Maximum probability 
out.maxpr(k) = max(Pij(:)); 
% Sum average 
out.savgh(k) = sum((ii+1).*p_xplusy); 
% Sum entropy 
out.senth(k) = -sum(p_xplusy.*log(p_xplusy+eps)); 
% Sum variance 
out.svarh(k) = sum((((ii+1) - out.senth(k)).^2).*p_xplusy); 
% Difference entropy 
out.denth(k) = -sum(p_xminusy.*log(p_xminusy+eps)); 
% Difference variance 
out.dvarh(k) = sum((jj.^2).*p_xminusy); 
% Computes correlation 
hxy1 = -sum(sum(Pij.*log(p_x*p_y' + eps))); 
hxy2 = -sum(sum((p_x*p_y').*log(p_x*p_y' + eps))); 
hx = -sum(p_x.*log(p_x+eps)); 
hy = -sum(p_y.*log(p_y+eps)); 
hxy = out.entro(k); 
% Information measure of correlation 1 
out.inf1h(k) = (hxy-hxy1)/(max([hx,hy])); 
% Information measure of correlation 2 
out.inf2h(k) = (1-exp(-2*(hxy2-hxy)))^0.5; 
% Cluster Prominence 
out.cprom(k) = sum(sum(Pij.*((i+j-u_x-u_y).^4))); 
% Cluster Shade 
out.cshad(k) = sum(sum(Pij.*((i+j-u_x-u_y).^3))); 
% 
s_x = sum(sum(Pij.*((i-u_x).^2)))^0.5; 
s_y = sum(sum(Pij.*((j-u_y).^2)))^0.5; 
corp = sum(sum(Pij.*(i.*j))); 
corm = sum(sum(Pij.*(i-u_x).*(j-u_y))); 
% Autocorrelation 
out.autoc(k) = corp; 
% Correlation paper 
out.corrp(k) = (corp-u_x*u_y)/(s_x*s_y); 
% Correlation Matlab 
out.corrm(k) = corm/(s_x*s_y); 
end