from subprocess import call

file = open('analyse.txt','r')
str = file.read()

str1 = str.split('\n');
sum = 0
avg=0
file1 = open('average.txt','w+')

for i in range(0,20):
	#print s1[0]
	for j in range(0,100):
		#print s1[1]
		s1 = str1[j+i*100].split(' ')
		#print j+100*i
		#print s1[0]
		#print s1[1]
		#print sum
		sum = sum + int(s1[1])
	avg = sum/100	
	#print avg
	#print j+100*i
	#print sum
	file1.write("%s %s\n" % (s1[0],avg))
	#print s1[0]
	#print s1[1]
	sum=0
	avg=0
#print s1[0]
#print s1[1]
#print j+100*i

file.close()
file1.close()
