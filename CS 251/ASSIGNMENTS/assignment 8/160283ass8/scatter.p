set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",12"
set ytics font ",12"
set ylabel font ",15"
set xlabel font ",15"

#set format y "10^{%L}"
set xlabel "num elements"
set ylabel "execution time"

set ytic auto
set xtic auto


set output "scatter1"
plot 'analyse.txt' every ::1::400 using 1:2 notitle with points pt 1 ps 1.5

set output "scatter2"
plot 'analyse.txt' every ::401::800 using 1:2 notitle with points pt 1 ps 1.5

set output "scatter3"
plot 'analyse.txt' every ::801::1200 using 1:2 notitle with points pt 1 ps 1.5

set output "scatter4"
plot 'analyse.txt' every ::1201::1600 using 1:2 notitle with points pt 1 ps 1.5

set output "scatter5"
plot 'analyse.txt' every ::1601::2000 using 1:2 notitle with points pt 1 ps 1.5

