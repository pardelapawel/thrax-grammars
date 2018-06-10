#!/bin/bash -e
FAR=$1
RULE=$2

function showUsage {
    <&2 echo "Runs lines through a given transducer"
    <&2 echo "Halts at first error"
    <&2 echo "Usage:"
    <&2 echo "$0 path/to/file.far rule < input.txt"
}

if [[ -z $FAR  || -z $RULE ]]; then
    showUsage
    exit 1;
fi

while read line
do
    echo -n "$line	"
     <<< "${line}" thraxrewrite-tester --far="${FAR}" --rules="${RULE}" | grep -Po "(?<=Output string: )(.+)"
done < /dev/stdin
