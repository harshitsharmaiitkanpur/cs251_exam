import sys
import numpy as np
import re
N_orig = sys.argv[1]
b = sys.argv[2]
b_num=0		#numeric value of b
length=len(b)
i=0
while i<length:
	b_num=b_num*10 + ord(b[i]) - ord('0');
	i+=1

def stripZeros(N_orig):
	if(N_orig[0]=='-'):
		pattern3=re.compile("^[-]?[0]+")
		str=re.sub(pattern3,'',N_orig)
		return str
	else:
		pattern3=re.compile("^[0]+")
		str=re.sub(pattern3,'',N_orig)
		return str

pattern1 = re.compile("^[-]?[0-9A-Z]+[.]{1}[0-9A-Z]+$")
pattern2 = re.compile("^[-]?[0-9A-Z]+$")
patternb = re.compile("^[1-9]+[0-9]*$")
def main():
	if (pattern1.match(N_orig) or pattern2.match(N_orig)) and patternb.match(b):
		N_stripped=stripZeros(N_orig)
		dec_ind=N_stripped.find(".")
		len_before=dec_ind
		len_after=len(N_stripped)-dec_ind-1
		if(dec_ind==-1):
			len_before=len(N_stripped)
			len_after=0
		num=0
		i=0
		arr=np.empty(len_before)
		if N_stripped[0]=='-':
			i+=1
		while i<len_before:
			if(N_stripped[i]>'9'):
				arr[i]=ord(N_stripped[i]) - ord('A') + 10
				if arr[i]>=b_num:
					print "Invalid Input"
					return
				i+=1
			else:
				arr[i]=ord(N_stripped[i]) - ord('0')
				if arr[i]>=b_num:
					print "Invalid Input"
					return
				i+=1 
		i=0
		while i<len_before:
			num=num*b_num + arr[i]
			i+=1

		if(dec_ind!=-1):
			i=0
			arr=np.empty(len_after)
			for i in range(len_after):
				if(N_stripped[i+len_before+1]>'9'):
					arr[i]=ord(N_stripped[i+len_before+1]) - ord('A') + 10
					if arr[i]>=b_num:
						print "Invalid Input"
						return
					i+=1
				else:
					arr[i]=ord(N_stripped[i+len_before+1]) - ord('0')
					if arr[i]>=b_num:
						print "Invalid Input"
						return
					i+=1

			i=len_after-1
			num2=0
			while i>=0:
				num2=(num2*1.0+arr[i])/b_num
				i-=1


		#PRINTING
		if dec_ind != -1:
			if N_stripped[0]=='-':
				print '-{}'.format(num+num2)
			else:
				print num+num2
		else:
			if N_stripped[0]=='-':
				print '-{}'.format(num)
			else:
				print num

	else:
		print "Invalid input"
	return

if __name__ == '__main__':
	main()