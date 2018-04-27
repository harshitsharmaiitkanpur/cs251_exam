data = csvread("train.csv");
x_train = data(:,1);
y_train = data(:,2);

#data
#length(x_train)
#size(y_train)

i = ones(10000,1);

X_train = [x_train,i];

X_train(:,1)= 1;
X_train(:,2)=x_train;

#X_train

w = rand(2,1);

scatter(x_train,y_train)
hold on;


w_T = w';
X_train_T = X_train';

y = w_T*X_train_T;

plot(x_train,y)
hold off;
pause()

w_direct = inv((X_train')*X_train)*(X_train')*y_train;

#size(w_direct)

scatter(x_train,y_train)
hold on;


y = (w_direct')*X_train_T;
plot(x_train,y)
hold off;
pause()

#size(w)

for i = 1:2,
	for j = 1:10000,
		x = data(j,1);
		y = data(j,2);
		x_2 = [1,x]';
		w = w - 0.00000001*(w'*x_2 - y)*x_2;
		j
		#fprintf("*%f\n*",w);
		if (mod(j,1000)==0),
			plot(x_train,y_train);
			hold on;
			y_ax = X_train*w;
			#size(y_ax)
			plot(x_train,y_ax);
			drawnow
			hold off;
		end,
	end,
end,
pause();
plot(x_train,y_train)
hold on;
plot(x_train,y_ax)
hold off;
pause();

w
data2 = csvread("test.csv");
x_test = data2(:,1);
y_test = data2(:,2);

i = ones(10500,1);

X_test = [x_test,i];

X_test(:,1)= 1;
X_test(:,2)=x_test;

y_pred1 = X_test*w;

ans = sqrt(mean((y_pred1-y_test).^2));
ans

y_pred2 = X_test*w_direct;

ans1 = sqrt(mean((y_pred2-y_test).^2));
ans1
