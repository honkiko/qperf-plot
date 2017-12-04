#!/usr/bin/env gnuplot

if (!exists("ARGC")) {
	print "This copy of gnuplot does not support the ARG call method"
	exit
}

if (ARGC < 2 || ARGC > 5) {
	print "usage: ", ARG0, " DATAFILE1 DATAFILE2 [DATAFILE3 [DATAFILE4 [DATAFILE5]]]"
	exit
}

bwfile="bw.png"
latfile="lat.png"

file1=ARG1
file2=ARG2
if (ARGC == 2) {
	bwfile=sprintf("bw-[%s]-vs-[%s].png",file1, file2)
	latfile=sprintf("lat-[%s]-vs-[%s].png",file1, file2)
}
if (ARGC == 3) {
	file3 = ARG3
	bwfile=sprintf("bw-[%s]-[%s]-[%s].png",file1, file2, file3)
	latfile=sprintf("lat-[%s]-[%s]-[%s].png",file1, file2, file3)
}
if (ARGC == 4) {
	file3 = ARG3
	file4 = ARG4
}
if (ARGC == 5) {
	file3 = ARG3
	file4 = ARG4
	file5 = ARG5
}


set xlabel "msg size (bytes)"
set ylabel "Throughput (MB/s)"
set logscale x 2
set style data linespoints 
set pointsize 2
set term png 
set output bwfile
if (ARGC == 2) {
	plot file1 using 1:2 title file1 pointtype 5 ,\
	file2 using 1:2 title file2 pointtype 5
}
if (ARGC == 3) {
	plot file1 using 1:2 title file1 pointtype 5 ,\
	file2 using 1:2 title file2 pointtype 5 ,\
	file3 using 1:2 title file3 pointtype 5
}
if (ARGC == 4) {
	plot file1 using 1:2 title file1 pointtype 5 ,\
	file2 using 1:2 title file2 pointtype 5 ,\
	file3 using 1:2 title file3 pointtype 5 ,\
	file4 using 1:2 title file4 pointtype 5
}
if (ARGC == 5) {
	plot file1 using 1:2 title file1 pointtype 5 ,\
	file2 using 1:2 title file2 pointtype 5 ,\
	file3 using 1:2 title file3 pointtype 5 ,\
	file4 using 1:2 title file4 pointtype 5 ,\
	file5 using 1:2 title file5 pointtype 5
}

set xlabel "msg size (bytes)"
set ylabel "Latency (us)"
set logscale x 2
set style data linespoints 
set pointsize 2
set term png 
set output latfile
if (ARGC == 2) {
	plot file1 using 1:3 title file1 pointtype 5 ,\
	file2 using 1:3 title file2 pointtype 5
}
if (ARGC == 3) {
	plot file1 using 1:3 title file1 pointtype 5 ,\
	file2 using 1:3 title file2 pointtype 5 ,\
	file3 using 1:3 title file3 pointtype 5
}
if (ARGC == 4) {
	plot file1 using 1:3 title file1 pointtype 5 ,\
	file2 using 1:3 title file2 pointtype 5 ,\
	file3 using 1:3 title file3 pointtype 5 ,\
	file4 using 1:3 title file4 pointtype 5
}
if (ARGC == 5) {
	plot file1 using 1:3 title file1 pointtype 5 ,\
	file2 using 1:3 title file2 pointtype 5 ,\
	file3 using 1:3 title file3 pointtype 5 ,\
	file4 using 1:3 title file4 pointtype 5 ,\
	file5 using 1:3 title file5 pointtype 5
}


