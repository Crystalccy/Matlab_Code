function Filtered_transIMG = myfilter(tranIMG,Len)

len_filter = max(64,2^nextpow2(2*Len));

F = 2*(0:(len_filter/2))./len_filter;
fre = 2*pi*(0:size(F,2)-1)/len_filter;

%F(2:end) = F(2:end).* cos(fre(2:end)/2);
F(2:end) = F(2:end) .*(1+cos(fre(2:end))) / 2;
F(fre>pi) = 0;                      
F = [F' ; F(end-1:-1:2)'];

tranIMG(length(F),1)=0;

Fre_transIMG = fft(tranIMG);

for i = 1:size(Fre_transIMG,2)
    Fre_transIMG(:,i) = Fre_transIMG(:,i).*F;
end

Filtered_transIMG = real(ifft(Fre_transIMG));
Filtered_transIMG(Len+1:end,:) = [];