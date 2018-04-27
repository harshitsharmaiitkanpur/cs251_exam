import os
import sys

N = sys.argv[1]
b = sys.argv[2]

N=N.lstrip("0")

if "." in N:
	N1,N2=N.split(".")
else:
	N1=N
	N2=0

#print N1
#print N2

def converter(b):
	base=0
	for digit in b:
		base*=10
		for d in '0123456789':
			base += digit > d
	return base

def value(c):
	if(ord(c) >= ord('0') and ord(c)<=ord('9')):
		return ord(c) - ord('0') 
	else:
		return ord(c) - ord('A') + 10

def todeci(N1,N2,base):
	l1=len(N1)
	if(N2!=0):
		l2=len(N2)
	power=1
	num=0
	
	if "-" in N1:
		for i in range(l1-1,0,-1):
			if(value(N1[i]) >= base):
				print "Invalid Input"
				return
			num += value(N1[i])*power
			power = power*base
		if(N2!=0):
			power=1
			for i in range(0,l2):
				if(value(N2[i]) >= base):
					print "Invalid Input"
					return
				power=float(power)/base
				num = float(num) + float(value(N2[i]))*float(power)
			print "-" + str(num)
		else:
			print "-" + str(num)

	if "-" not in N1:
		for i in range(l1-1,-1,-1):
			if (value(N1[i]) >= base):
				print "Invalid Input"
				return
			num += value(N1[i])*power
			power = power*base
		if(N2!=0):
			power=1
			for i in range(0,l2):
				if(value(N2[i]) >= base):
					print "Invalid Input"
					return
				power = float(power)/base
				#print power
				num = float(num) + float(float(value(N2[i]))*float(power))
				
			print num
		else:
			print  num
#str1="D"
#a=value(str1[0])
#print a
base=converter(b)
#print  base
todeci(N1,N2,base)


