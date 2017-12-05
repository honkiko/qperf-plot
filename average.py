#!/usr/bin/env python
# -*- coding: utf-8 -*-
# author: zhiguohong@tencent.com

import sys
import operator

# bytes MB/s us
# 64 43.1 200
def load_data(file):
    bw = {}
    lat = {}
    lines = [line.rstrip('\n') for line in open(file)]
    for line in lines:
        if line.startswith("#"):
            continue
        tokens = line.split()
        bytes = int(tokens[0])
        bw[bytes] = float(tokens[1])
        lat[bytes] = int(tokens[2])
    return bw, lat

def sum(tbl, sum):
    for bytes, v in tbl.iteritems():
        if bytes not in sum:
            sum[bytes] = v
            continue
        sum[bytes] = sum[bytes] + v


if __name__ == '__main__':
    bw_avg = {}
    lat_avg = {}
    files = sys.argv[1:]
    for file in files:
        bw, lat = load_data(file)
        sum(bw, bw_avg)
        sum(lat, lat_avg)

    n = len(files)

    for bytes, v in bw_avg.iteritems():
        bw_avg[bytes] = bw_avg[bytes] / n

    for bytes, v in lat_avg.iteritems():
        lat_avg[bytes] = lat_avg[bytes] / n

    sorted_bw = sorted(bw_avg.items(), key=operator.itemgetter(0))

    print "# msgsize(Bytes) bw(MB/sec) lat(us)"
    for item in sorted_bw:
        bytes = item[0]
        print "%d %.1f %d" % (bytes, item[1], lat_avg[bytes])


