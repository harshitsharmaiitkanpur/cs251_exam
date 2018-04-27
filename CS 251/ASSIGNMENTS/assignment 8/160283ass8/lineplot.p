#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",12"
set ytics font ",12"
set ylabel font ",15"
set xlabel font ",15"

set xlabel "num-elements"
set ylabel "average-execution-time"

set ytic auto
set xtic auto

set key bottom right

set output "line plot3(b)"
plot 'average.txt' every ::0::3 using 1:2 title  "Threads 1" with linespoints, \
     '' every ::4::7 using 1:2 title  "Threads 2" with linespoints pt 5 lc 5, \
     '' every ::8::11 using 1:2 title  "Threads 4" with linespoints lc 4, \
     '' every ::12::15 using 1:2 title  "Threads 8" with linespoints lc 3, \
     '' every ::16::19 using 1:2 title  "Threads 16" with linespoints lc 2


