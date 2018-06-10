#Quick numeral test
`make && seq 100 21 999 | ./test.sh transducer.far RULE`

#Quick ourput test
`thraxrandom-generator --input_mode=utf8 --far=transducer.far --rule=RULE --noutput=10`

#Draw transducer
`make && farextract --keys=RULE transducer.far && xdot <(fstdraw RULE) && rm RULE`
