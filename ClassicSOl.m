


data=load('data for my project.mat');
R=data.Return;
shares=data.Shares;

% Now we just consider 'portfolio' variable as an 'PORTFOLIO objcet' and put specified 'R', which has introducesd recently%

portfolio=Portfolio();


% by implementing following function, we would get the VAR  & MEAN of the data.

portfolio=portfolio.estimateAssetMoments(R);

% As we are working on a basic constriant portfolio Optimizatoin, we set portfolio as default constraint :

portfolio=portfolio.setDefaultConstraints();

%This problem is a kind of multi objective problem, therefor we have several solutions ..
%which are absolutely depend on the situation(the level of the risk or return). so we determine 20(optional) scenarios BY:



Weight=portfolio.estimateFrontier(20);


%for each scenario (20) we have to understand what RISK & RETURN we are
%obtaining SO :
RISK=portfolio.estimatePortRisk(Weight);

RETURN=portfolio.estimatePortReturn(Weight);

% Here we're gonna plot the efficient frontier which is obtained by 20
% scenarios.

plot(RISK,RETURN,'linewidth',5);
hold on

%to clarify where share's locations are, we must determine the variance and Mean for each share.
%the share's Variance will be obtained by the Matrix of COVARIANCE.
%(notice that cov(x,x)=var(x) )

SIGMA=sqrt(portfolio.AssetCovar)
MEAN=portfolio.AssetMean

for i=1:10
    
   sigma=SIGMA(i,i)
   mean=MEAN(i)
   scatter(sigma,mean,'r','filled')
    %name=shares{i}
    text(sigma,mean,shares{i})
end

xlabel('Risk');
ylabel('Return');
title('Effiecient Frontier');

%In order to achieve efficient Frontier, we estimate 20(potional) points on the efficient frontier which explain a special scenario.
