CC=gcc
CGCC=nvcc
CFLAGS=-I. -g
CUDACFLAGS=--gpu-architecture=sm_60
LDFLAGS=-lm -lpthread

all: simple gpu cpu

cpu:parcpu.c
	$(CC) $(CFLAGS) parcpu.c $(LDFLAGS) -o cpu

simple:simple.cu
	$(CGCC) $(CFLAGS) $(CUDACFLAGS) simple.cu $(LDFLAGS) -o simple
gpu:pargpu.cu
	$(CGCC) $(CFLAGS) $(CUDACFLAGS) q1.cu $(LDFLAGS) -o q1

clean:
	rm -f *.o cpu gpu simple
	
