#!/usr/bin/env gnuplot

if (!exists("ARGC")) {
	print "This copy of gnuplot does not support the ARG call method"
	exit
}

if (ARGC != 2) {
	print "usage: ", ARG0, " DATAFILE1 DATAFILE2"
	exit
}

file1=ARG1
file2=ARG2

set xlabel "msg size (bytes)"
set ylabel "Throughput (MB/s)"
set logscale x 2
set style data linespoints 
set pointsize 2
set term png 
set output "bw.png" 
plot file1 using 1:2 title file1 pointtype 5 , file2 using 1:2 title file2 pointtype 5

set xlabel "msg size (bytes)"
set ylabel "Latency (us)"
set logscale x 2
set style data linespoints 
set pointsize 2
set term png 
set output "lat.png" 
plot file1 using 1:3 title file1 pointtype 5 , file2 using 1:3 title file2 pointtype 5
