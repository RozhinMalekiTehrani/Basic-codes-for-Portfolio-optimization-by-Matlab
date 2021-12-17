%... 
%SHARES:
%?????? 
%??????
%????
%????
%????
%?????
%?????
%????
%?????
%?????

                         %vabesader ,valesapa ,vahur ,sheraz ,sekord ,shabandar ,khsapa ,kegohar ,ghesinu ,ghemarg
                      
                         %these shares are respectively known as:
                         
                         %: S(1), S(2), S(3), S(4), S(5), S(6), S(7) ,S(8) ,S(9) ,S(10)
    clc; 
    clear all;
   S={'vabesader' ,'valesapa' ,'vahur' ,'sheraz' ,'sekord' ,'shabandar' ,'khsapa' ,'kegohar' ,'ghesinu' ,'ghemarg'};
 Price=[];
 Rerturn=[];
 Date=[];
    for i = 1 : 10

    filename = sprintf('S(%d).csv',i);
  p=xlsread(filename,'L2:L61');
  Price=[Price p];
   r=(xlsread(filename,'N2:N61'))*100;
   Rerturn=[Rerturn r];
     d= xlsread(filename,'B2:B61');
     Date=[Date d];
    end
    plot(Price);
    legend(S)
    figure(2)
    plot(Rerturn);
    legend(S)

    save('data for my project','Price','Rerturn','Date')
