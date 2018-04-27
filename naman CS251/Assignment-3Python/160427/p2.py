import numpy as np
import matplotlib.pyplot as plt

def plotData(X,y,w):
	plt.plot(X[:,1],y,'ro')
	plt.ylabel('y')	
	plt.xlabel('X_train')

	h=np.dot(X,w)
	plt.plot(X[:,1],h,'')
	plt.show()
	return

mydata=np.genfromtxt('train.csv',delimiter=',',skip_header=1)
X_train=mydata[:,0].reshape(mydata.shape[0],1).astype(float)
y=mydata[:,1].reshape(mydata.shape[0],1).astype(float)
n=X_train.shape[0]
#add column
X_train=np.concatenate((np.ones((X_train.shape)),X_train),axis=1)
w=np.random.rand(2,1)

plotData(X_train,y,w)

w_direct=(1.0/np.dot(X_train[:,1].T,X_train[:,1]))*np.dot(X_train.T,y)
plotData(X_train,y,w_direct)

## TRAINING
num_epoch=2
eta=0.00000001
for i in range(num_epoch):
	for j in range(n):
		val=np.dot(X_train[j,:].flatten(),w.flatten())-y[j].flatten()
		w = w- eta*X_train[j,:].reshape(2,1)*val
		if j%100 == 0:
			plotData(X_train,y,w)

plotData(X_train,y,w)

#READ FILE
mydata2=np.genfromtxt('test.csv',delimiter=',',skip_header=1)
X_test=mydata2[:,0].reshape(mydata2.shape[0],1).astype(float)
y_test=mydata2[:,1].reshape(mydata2.shape[0],1).astype(float)
n=X_test.shape[0]
#add column
X_test=np.concatenate((np.ones((X_test.shape)),X_test),axis=1)


y_pred1 = np.dot(X_test,w)
rms_err=np.sqrt(np.mean(np.square(y_pred1- y_test)))
print rms_err

y_pred2 = np.dot(X_test,w_direct)
rms_err2=np.sqrt(np.mean(np.square(y_pred2- y_test)))
print rms_err