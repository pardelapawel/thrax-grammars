.PHONY: clean %.rand

%.far: %.mk
	$(MAKE) -f $<
	#thraxcompiler --save_symbols --input_grammar=$< --output_far=$@

%.mk: %.grm
	thraxmakedep --save_symbols $< $@

%.rand: %.far
	thraxrandom-generator --far=$< --rule=MAIN --noutput=10
	#thraxrandom-generator --input_mode=utf8 --far=$< --rule=MAIN --noutput=10

ko-KR/syllable2jamo.grm: tools/syllable2jamo.rb
	ruby $< > $@


clean:
	rm -f *.far *.mk
