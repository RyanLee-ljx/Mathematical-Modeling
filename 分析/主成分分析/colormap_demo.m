clear,close all; 

% official
figure; 
surf(peaks); 
title('official (default)'); 
set(gca,'fontsize',14); 
set(gcf,'color','w'); 
colormap default; 



% othercolor
figure; 
surf(peaks); 
title('othercolor (PuBu6)'); 
set(gca,'fontsize',14); 
set(gcf,'color','w'); 
colormap(othercolor('PuBu6')); 

