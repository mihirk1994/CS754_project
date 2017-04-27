#!/bin/bash
for i in {1..10}
do
start=$(($((i-1))*60))
ending=$(($i*60))
ffmpeg -i lankershim-camera4-0830am-0845am-processed.avi -ss $start -t 60 ten-min-$i.avi
done
