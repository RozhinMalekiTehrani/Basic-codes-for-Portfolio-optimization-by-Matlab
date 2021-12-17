clc;
clear all;


% t : the number of portfolios would be obtained by running k-means once
%once
t=3;

%k: the number of clusters ink-means
k=50;



data=load('clustering data.mat');
Name=data.Names;
Ret=data.Return;

myportfolio=Portfolio();
myportfolio=myportfolio.estimateAssetMoments(Ret);



myportfolio=myportfolio.setDefaultConstraints();

W=myportfolio.estimateFrontier(20);



%determine the covariance matrix and variance
SIGMA=(myportfolio.AssetCovar);
VARIANCE=diag(SIGMA);

% and also compute MU of each asset
Mu=myportfolio.AssetMean;

%DR_IDEAL_MARK=(sqrt(VARIANCE)*W)/(sqrt(W(:,1)'*SIGMA*W));

%now it's the time to create the specified data to implement k-means algorithm
DATA=[Mu SIGMA];

S=kmeans(DATA,k);
P=zeros(t,k);
s=cell(1,k);

AssetsName_eachcluster=cell(1,k);


%cov_mat=[]
%mu_mat=[];


for i=1:k
    s{i}=find(S==i);
    AssetsName_eachcluster{i}=Name{1,s{i}};
end



figure
for j=1:t

for i=1:k
    port(i)=s{i}(randi(numel(s{i})));
    P(j,i)=s{i}(randi(numel(s{i})));
    %Name{1,s(j,:)}
end
figure
%subplot(1,t,j);
x= categorical(Name{1,port(:)});

pie(x,Name{1,port(:)});
%to allocate assets equally, we have to make an equal slice of each asset in the pie , there we have ones(1,k) in 'pie' code.
%pie(ones(1,k),Name{1,port(:)})

colormap cool




% mu_mat=[mu_mat Mu(P(j,:))];
% cov_mat=[cov_mat (SIGMA(P(j,:)))']
%sigma=(sigma sqrt(VARIANCE(P(j,:))'));
end

figure
%pareto of Markowitz model(which we put it in practice for all 110 assets)
Risk_Mark=myportfolio.estimatePortRisk(W);

Return_Mark=myportfolio.estimatePortReturn(W);

plot(Risk_Mark,Return_Mark,'linewidth',4,'color','r');
xlabel('Risk');
ylabel('Return');
title(sprintf('Effiecient Frontiers for K = %d',k));

%LEG=cell(1,t+1)
%LEG{1,1}='Ideal'

hold on


W_eqcluster=(ones(1,k))/k;
for j=1:t
return_for_paretocluster=data.Return(:,P(j,:));
my_portfolio2=Portfolio();
my_portfolio2=my_portfolio2.estimateAssetMoments(return_for_paretocluster);
covar_cluster=(my_portfolio2.AssetCovar);
standard_dev_cluster=sqrt(diag(covar_cluster));
my_portfolio2=my_portfolio2.setDefaultConstraints();
Weight_cluster=my_portfolio2.estimateFrontier(20);

RISK_cluster=my_portfolio2.estimatePortRisk(Weight_cluster);

RETURN_cluster=my_portfolio2.estimatePortReturn(Weight_cluster);

c=randi([0 1],1,3);

plot(RISK_cluster,RETURN_cluster,'linewidth',2,'Marker','d','Markerfacecolor',c);

%%%compute diversification
%DR_cluster(j)=(standard_dev_cluster' * W_eqcluster')/sqrt(W_eqcluster*covar_cluster*W_eqcluster')







%LEG{1,j+1}=[LEG sprintf('k-portfolio %d', j)]


%risk_cluster= sqrt(W_cluster * covar_cluster * (W_cluster)');
%return_cluster=W_cluster * mu_mat(:,j)
%scatter(risk_cluster ,return_cluster,'filled')
%legend(sprintf('k-portfolio %d', j) )

%LEG=[LEG sprintf('k-portfolio %d', j)]
hold on
end
legend('Ideal', 'k-portfolio1','k-portfolio2','k-portfolio3')




%separated pies
figure
for j=1:t

for i=1:k
    port(i)=s{i}(randi(numel(s{i})));
    P(j,i)=s{i}(randi(numel(s{i})));
end

subplot(1,t,j);
x= categorical(Name{1,port(:)});

pie(x,Name{1,port(:)});
%to allocate assets equally, we have to make an equal slice of each asset in the pie , there we have ones(1,k) in 'pie' code.

colormap cool

end



save('variablesclusterk=50')