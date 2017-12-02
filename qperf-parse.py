#!/usr/bin/env python
# -*- coding: utf-8 -*-
# author: zhiguohong@tencent.com

import sys
import operator


STATE_NIL = 0
STATE_BW  = 1
STATE_LAT = 2

if __name__ == '__main__':
    state = STATE_NIL
    bw = 0.0
    lat = 0.0

    mix_dict = {}

    for line in sys.stdin:
        str = line.strip()
        if str.startswith("tcp_bw:"):
            continue
        if str.startswith("tcp_lat:"):
            continue

        if str.startswith("bw"):
            tokens = str.split()
            # ['bw', '=', '49.9', 'MB/sec']
            assert tokens[3] == 'MB/sec', "Not supported unit {}".format(tokens[3])
            bw = float(tokens[2])
            state = STATE_BW
            continue

        if str.startswith("latency"):
            tokens = str.split()
            if tokens[3] == 'us':
                unit = 1
            elif tokens[3] == 'ms':
                unit = 1000
            else:
                sys.exit("Not supported unit {}".format(tokens[3]))
            lat = float(tokens[2]) * unit
            state = STATE_LAT
            continue

        if str.startswith("msg_size"):
            tokens = str.split()
            if tokens[3] == 'bytes':
                unit = 1
            elif tokens[3] == 'KiB':
                unit = 1024
            else:
                sys.exit("Not supported unit {}".format(tokens[3]))

            msgsize = int(tokens[2]) * unit
            if state == STATE_BW:
                if msgsize not in mix_dict:
                    record = [-1, -1]
                    mix_dict[msgsize] = record
                mix_dict[msgsize][0] = bw
            elif state == STATE_LAT:
                if msgsize not in mix_dict:
                    record = [-1, -1]
                    mix_dict[msgsize] = record
                mix_dict[msgsize][1] = lat
            else:
                sys.exit("Bad state {}".format(state))


    sorted_mix = sorted(mix_dict.items(), key=operator.itemgetter(0))
    
    print "# msgsize(Bytes) bw(MB/sec) lat(us)"
    for item in sorted_mix:
        print "%d %.1f %d" % (item[0], item[1][0], item[1][1])







