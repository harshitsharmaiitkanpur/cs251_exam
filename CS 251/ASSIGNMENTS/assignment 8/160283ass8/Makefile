all:App

CFLAGS = -g -DDBG -I.
FLAG = -lm

runtest: ./App params.txt threads.txt
	bash report_gen.sh params.txt threads.txt
analyse: ./report_gen.sh output.txt params.txt threads.txt
	bash analyse.sh output.txt params.txt threads.txt
App:prog.o thread_function.o
	gcc $(CFLAGS) -o App prog.o thread_function.o $(FLAG) -lpthread

prog.o:prog.c common.h thread_function.o
	gcc $(CFLAGS) -c prog.c -o prog.o $(FLAG) -lpthread
thread_function.o:thread_function.c common.h
	gcc $(CFLAGS) -c thread_function.c -o thread_function.o $(FLAG) -lpthread
analyse1:./average.py
	python average.py 
plot1: analyse
	gnuplot scatter.p
plot2: analyse1
	gnuplot lineplot.p 
plot: plot1 plot2

report: scatter1 scatter2 scatter3 scatter4 scatter5 
	latex report.tex  
		
.PHONY:clean
clean:
	rm -f *.o 
