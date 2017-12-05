# qperf-plot

Parse qperf reports, plot bandwidth and latency diagrams.

## Dependencies
- python
- gunplot above 5.0

## How to use it
#### First prepare 2 qperf reports

For example:
```
# suppose qperf (server mode) is running on NODE1 and NODE2
qperf $NODE1 -oo msg_size:64:64K:*2 -vu -vvc tcp_bw tcp_lat > test1.raw
qperf $NODE2 -oo msg_size:64:64K:*2 -vu -vvc tcp_bw tcp_lat > test2.raw
```
The content of test*.raw looks like:
```
tcp_bw:
    bw        =  76.6 MB/sec
    msg_size  =    64 bytes
tcp_bw:
    bw        =  70.1 MB/sec
    msg_size  =   128 bytes
...
tcp_lat:
    latency   =  663 us
    msg_size  =   32 KiB (32,768)
tcp_lat:
    latency   =  1.1 ms
    msg_size  =   64 KiB (65,536)
```

#### Parse qperf raw reports into gnuplot data files
```
cat test1.raw | ./qperf-parse.py > test1
cat test2.raw | ./qperf-parse.py > test2

```
The content of data file test* looks like:
```
# msgsize(Bytes) bw(MB/sec) lat(us)
64 76.6 183
128 70.1 178
256 87.0 171
512 107.0 190
1024 85.6 211
2048 84.5 225
4096 76.1 269
8192 90.5 317
16384 83.6 452
32768 81.0 663
65536 92.9 1100
```

#### Generate diagrams by gnuplot
```
gnuplot -c qperf-plot.plt test1 test2
```

Tow png file will be generated:

- bw.png   Bandwidth comparasion diagram between 2 tests
- lat.png  Latency comparasion diagram between 2 tests

bw.png:

![Alt text](example-stuff/bw.png?raw=true "bw.png")

lat.png:

![Alt text](example-stuff/lat.png?raw=true "lat.png")


## Contribution
It simply works but I hope it to be more powerful in future.

Issues and Pull-Requests are welcome.
