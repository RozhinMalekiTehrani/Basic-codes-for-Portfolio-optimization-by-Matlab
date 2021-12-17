%SHARES:110 shares 
    clear all;
 
    Names=cell(1,110);
  %save the name of each share
    Names=readtable('name.csv');
    
    %save the close price of each share 
   filename='Datacluster';
  P=xlsread(filename,'A2:DF66');
  
  %computing thereturns of each asset.
  Return=tick2ret(P);
    plot(Return,'linewidth',2);
    xlabel('Day');
    ylabel('Return');
    legend(Names{1,:});
    
save('clustering data','Return','Names')