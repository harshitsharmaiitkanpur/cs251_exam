
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sys
import os


# In[2]:


data = pd.read_csv(sys.argv[1])


# In[3]:


data=np.array(data)


# In[4]:


x_train = data[:,0]
y_train = data[:,1]


# In[5]:


xx= np.zeros((x_train.size,2))


# In[6]:


xx


# In[7]:


xx[:,1] = x_train


# In[8]:


xx


# In[9]:


xx[:,0] = 1


# In[10]:


xx


# In[11]:


X_train = xx


# In[12]:


print X_train


# In[13]:


w = np.random.rand(2,1)

print w
# In[14]:


w.shape


# In[15]:


y_train.shape


# In[16]:



plt.plot(x_train,y_train,'ro')


# In[17]:


plt.show()


# In[18]:


x1 = X_train.transpose()


# In[19]:


x1


# In[20]:


y=w.transpose().dot(x1)


# In[21]:


w.shape


# In[22]:


y.shape


# In[23]:


y1=np.array(y)


# In[24]:


y1.shape


# In[25]:


y1=y1.flatten('F')


# In[26]:


y1.shape


# In[27]:


x_train.shape


# In[28]:


y1.shape


# In[29]:


plt.plot(x_train,y_train,'ro')
plt.plot(x_train,y1)


# In[30]:


plt.show()


# In[31]:


X_train.shape


# In[32]:


X_train


# In[33]:


w1=X_train.transpose().dot(X_train)


# In[34]:


w1


# In[35]:


w1.shape


# In[36]:


w_inv=np.linalg.inv(w1)


# In[37]:


w_inv


# In[38]:


w_inv.shape


# In[39]:


a=X_train.transpose().dot(y_train).reshape(2,1)


# In[40]:


a


# In[41]:


y_train


# In[42]:


a=a.reshape(2,1)


# In[43]:


w_direct=w_inv.dot(a)


# In[44]:


w_direct


# In[45]:


w_direct.shape


# In[46]:


plt.plot(x_train,y_train,'ro')


# In[47]:


plt.show()


# In[48]:


x1.shape


# In[49]:


x1


# In[50]:


y_axis=w_direct.transpose().dot(x1)


# In[51]:


y_axis.shape


# In[52]:


x_train.shape


# In[53]:


plt.plot(x_train,y_axis.T)
plt.plot(x_train,y_train)
plt.show()


# In[54]:


plt.show()


# In[55]:


w.shape


# In[56]:


w = np.random.rand(2,1)


# In[57]:


w.shape


# In[58]:


y_train.shape


# In[59]:


for i in range(1,3):
    for j in range(1,10001):
        x=data[j-1,0]
        y=data[j-1,1]
        x2=np.array([1,x])
        x_new=x2.reshape(2,1)
        #print w.shape
        w=w-0.00000001*(w.transpose().dot(x_new) - y)*(x_new)
        #print w.shape
        if j%100==0:
            ala=0
            plt.plot(x_train,y_train)
            y_ax=w.transpose().dot(X_train.T)
            #print w.shape
            plt.plot(x_train,y_ax.T)
            plt.show()
#plt.scatter(x_train,y_train,s=100)
#plt.plot(x_train,y_ax.T)
#plt.show()
#print w


# In[89]:


plt.plot(x_train,y_train)
plt.plot(x_train,y_ax.T)
plt.show()


# In[91]:


data2 = pd.read_csv(sys.argv[2])


# In[92]:


data2=np.array(data2)


# In[93]:


print data2


# In[94]:


x_test = data2[:,0]
y_test = data2[:,1]


# In[95]:


x_test


# In[96]:


y_test=y_test.reshape(10500,1)


# In[97]:


y_test.shape


# In[98]:


xx2 = np.zeros((x_test.size,2))


# In[99]:


xx2


# In[100]:


xx2[:,1] = x_test


# In[101]:


xx2


# In[102]:


xx2[:,0]=1


# In[103]:


xx2


# In[104]:


X_test=xx2


# In[105]:


X_test


# In[106]:


y_pred1=X_test.dot(w)


# In[107]:


y_pred1


# In[108]:


y_pred1.shape


# In[109]:


ans=np.sqrt(np.mean((y_pred1-y_test)**2))


# In[110]:


print ans


# In[111]:
b=X_test.T.dot(y_test)


# In[158]:




w_direct


# In[112]:


y_pred2=X_test.dot(w_direct)


# In[113]:


y_pred2


# In[114]:


y_pred2=y_pred2.reshape(10500,1)


# In[115]:


y_pred2.shape


# In[116]:


y_test.shape


# In[117]:


ans1=np.sqrt(np.mean((y_pred2-y_test)**2))


# In[118]:


print ans1 + 40

