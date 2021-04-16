#! /bin/bash

set -eux 

if cd Flamegraph; then git pull && cd ..; else git clone https://github.com/brendangregg/FlameGraph; fi
rm -rf samples
mkdir -p samples
cat ../profile/* | ./Flamegraph/stackcollapse.pl > samples/samples.collapsed
python3 filter.py --mode wakeups --stack_file samples/samples.collapsed > samples/samples.collapsed.filtered
cat ./samples/samples.collapsed.filtered | ./Flamegraph/flamegraph.pl --colors wakeup -w 3000 > ./samples/wakeups_flames.svg
