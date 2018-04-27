num_samples <- 50000
data <- rexp(num_samples, 0.2)
x <- data.frame(X = seq(1, num_samples , 1), Y = sort(data))
#X <- data.frame(seq(1, num_samples , 1))
#lengths(X)
#lengths(data)
plot(x)

mat_a <- matrix(0, 500, 100)
#dim(mat_a)
for(i in 1:500){
	for(j in 1:100){
	mat_a[i,j] <- round(data[100*(i-1) +j],0);
    
    }
}
#data
#mat_a

Y1= mat_a[1,]
Y2= mat_a[2,]
Y3= mat_a[3,]
Y4= mat_a[4,]
Y5= mat_a[5,]

#Y1
#Y2

C1 = ecdf(Y1)
C2 = ecdf(Y2)
C3 = ecdf(Y3)
C4 = ecdf(Y4)
C5 = ecdf(Y5)

plot(C1)
plot(C2)
plot(C3)
plot(C4)
plot(C5)

P1 = density(Y1)
P2 = density(Y2)
P3 = density(Y3)
P4 = density(Y4)
P5 = density(Y5)

plot(P1)
plot(P2)
plot(P3)
plot(P4)
plot(P5)

m1<-mean(Y1)
m2<-mean(Y2)
m3<-mean(Y3)
m4<-mean(Y4)
m5<-mean(Y5)

sd1<-sd(Y1)
sd2<-sd(Y2)
sd3<-sd(Y3)
sd4<-sd(Y4)
sd5<-sd(Y5)


print("MEAN of Y1") 
m1
print("MEAN of Y2")  
m2  
print("MEAN of Y3")
m3  
print("MEAN of Y4")
m4  
print("MEAN of Y5")
m5

print("SD of Y1")
sd1  
print("SD of Y2")
sd2  
print("SD of Y3")
sd3  
print("SD of Y4")
sd4  
print("SD of Y5")
sd5

mean <- matrix(0,500,1)
st_dev <- matrix(0,500,1)
#dim(mean)
for(i in 1:500){

	mean[i,1]<-mean(mat_a[i,])
	st_dev[i,1]<-sd(mat_a[i,]);

}
#mean
tab <- table(round(mean))

#str(tab)
plot(tab, "h", xlab="Z", ylab="Frequency of means")

Mean = mean[,1]
C = ecdf(Mean)
plot(C)

Mean = mean[,1]
#Mean
P = density(Mean)
plot(P)

Final_mean <- mean(mean)
Final_sd <- sd(mean)
init_mean <- mean(data)
init_sd <- sd(data)

print("Final_mean of Z is ")
Final_mean

print("Final_sd of Z is ")
(Final_sd)*10

print("Mean of original dist. ")
init_mean

print("SD of original dist. ")
init_sd


