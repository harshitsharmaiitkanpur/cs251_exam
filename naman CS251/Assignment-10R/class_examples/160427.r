l=0.2
x=rexp(50000,rate=l)
sorted_x=sort(x)
plot(1:50000,sorted_x,main="Exponential Distibution",xlab="",ylab="",cex=0.2)
data_spl=split(x,1:500)
for(j in 1:5)
{
	x_new=sort(unlist(data_spl[j]))
	pdf=l*exp(-l*x_new)
	cdf=cumsum(pdf)/sqrt(100)
	
	pdata <- rep(0, 100);
	for(i in 1:100){
		val=round(x_new[i]);
	    if(val <= 100){
		    pdata[val] = pdata[val] + 1/100;
		}
	}
	
	xcols=c(0:99)
	plot(xcols, pdata, "l", xlab="X", ylab="f(X)",main="PDF",sub=paste("Data Segment No.",j))
	plot(x_new, cdf,"l",xlab="X", ylab="F(X)",main="CDF")

	cat("Mean:",mean(x_new),"\n")
	cat("Std Dev:",sd(x_new),"\n")
}

means=rep(0,500)
for(i in 1:500)
{
	x_new=sort(unlist(data_spl[i]))
	means[i]=mean(x_new)
}

x_new=sort(means)
pdf=l*exp(-l*x_new)
cdf=cumsum(pdf)
cdf=cdf/cdf[500]
xcols=c(0:19)
pdata <- rep(0, 20);
for(i in 1:500){
    val=round(x_new[i]);
    if(val <= 20){
         pdata[val] = pdata[val] + 1/500;
    }
}
tab=table(round(x_new))

plot(tab,"h",xlab="Value",ylab="Frequency")
plot(xcols, pdata, "l", xlab="X", ylab="f(X)",main="PDF")
plot(x_new, cdf,"l",xlab="X", ylab="F(X)",main="CDF")
cat("Mean of distributions:",mean(means),"\n")
cat("Std Dev of distributions:",sd(means),"\n")

cat("Original Mean:",mean(x),"\n")
cat("Original StdDev:",sd(x),"\n")
