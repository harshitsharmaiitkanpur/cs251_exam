function ret=plotData(x_old,y_train,w,phrase)
hold on;
scatter(x_old,y_train,'b',S='0.6');
xlabel("xtrain");
ylabel("ytrain");
title(phrase);
hold on;
v=[min(x_old):1:max(x_old)];
v=rotdim(v,3);
v_dash=[ones(size(v)(1),1),v];
plot(v,w'*v_dash','r');
pause(1);
close;
ret=1;
endfunction


#STEP1
data=csvread('train.csv');
n=size(data)(1)-1;
x_train=data(2:end,1);
x_old=x_train;
y_train=data(2:end,2);
x_train=[ones(n,1),x_train];

#STEP2
w=rand(2,1);

#STEP3
plotData(x_old,y_train,w,"Graph for some random weights");

#STEP4
w_direct=inv(x_train'*x_train)*(x_train'*y_train);
plotData(x_old,y_train,w_direct,"Graph for direct weights");

#STEP5
num_epoch=2;
eta=0.00000001;
for i=1:num_epoch,
for j=1:n,
dp=x_train(j,:);
w=w-eta*(dp*w-y_train(j))*dp';

if(!mod(j,100) & j<1000),
plotData(x_old,y_train,w,"Training Data");
end,
end,
end,

#STEP6
plotData(x_old,y_train,w,"After training");

#STEP7
tstd=csvread('test.csv');
n_test=size(tstd)(1)-1;
x_test=tstd(2:end,1);
x_test_old=x_test;
y_test=tstd(2:end,2);
x_test=[ones(n_test,1),x_test];

y_pred1=x_test*w;
y_pred2=x_test*w_direct;
disp("RMS1="),disp(sqrt((1/n)*sum((y_pred1-y_test).**2)))
disp("RMS2="),disp(sqrt((1/n)*sum((y_pred2-y_test).**2)))















