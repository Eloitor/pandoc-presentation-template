.PHONY: beamer entr clean preview

files_to_watch = $(shell find src/ -type f)
# Change src/ to preview/
preview_slides = $(shell find src/ -type f | sed 's/src/preview/g' | sed 's/\.md/\.pdf/g')

beamer: output/presentation-notes-2x3.pdf output/print-notes-2x3.pdf output/presentation-2x3.pdf output/print-2x3.pdf
entr:
	while true; do \
		ls -d $(files_to_watch) | entr -d -p make beamer; \
	done
	echo "${files_to_watch}" | entr -c make beamer

clean:
	rm -f output/*
	rm -f preview/*

output/presentation.pdf: ${files_to_watch}
	pandoc -s \
		--columns=50 \
		--defaults=defaults.yaml \
		-V classoption:aspectratio=169 -t beamer -o $@ src/*.md

output/presentation-notes.pdf: ${files_to_watch}
	pandoc -s \
		--columns=50 \
		--defaults=defaults.yaml \
		-V beameroption:"show notes on second screen=right" \
		-V beamertemplate:"{note page}[plain]" \
		-V classoption=notes \
		-V classoption:aspectratio=169 -t beamer -o $@ src/*.md

output/print.pdf : ${files_to_watch}
	pandoc -s \
		--columns=50 \
		--defaults=defaults.yaml \
		-V handout \
		-V classoption:aspectratio=169 -t beamer -o $@ src/*.md

output/print-notes.pdf: ${files_to_watch}
	pandoc -s \
		--columns=50 \
		--defaults=defaults.yaml \
		-V handout \
		-V classoption:notes \
		-V beameroption:"show notes on second screen=right" \
		-V beamertemplate:"{note page}[plain]" \
		-V classoption:aspectratio=169 -t beamer -o output/print-notes.pdf src/*.md

output/notes.epub: ${files_to_watch}
	pandoc -o $@ \
	--lua-filter=filters/extract-notes.lua \
	--lua-filter=filters/latex-color.lua \
	src/*.md


# How to join this two rules?
output/%-notes-2x3.pdf: output/%-notes.pdf
	pdfjam $< --nup 1x3 --keepinfo \
		--paper a4paper --frame true \
		--landscape \
		--suffix "2x3" \
		--outfile $@

 output/notes-2x3.pdf: output/notes.pdf
	pdfjam $< --nup 1x3 --keepinfo \
		--paper a4paper --frame true \
		--landscape \
		--suffix "2x3" \
		--outfile $@

output/%-2x3.pdf: output/%.pdf
	pdfjam $< --nup 2x3 --keepinfo \
		--paper a4paper --frame true \
		--landscape \
		--suffix "2x3" \
		--outfile $@

live_preview: preview
	make preview
	while true; do \
		ls -d $(files_to_watch) | entr -d -p make preview; \
	done
	echo "${files_to_watch}" | entr -c make preview

preview: ${preview_slides}

preview/%.pdf: src/%.md
	pandoc -s \
		--columns=50 \
		--defaults=defaults.yaml \
		-V classoption:notes \
		-V beameroption:"show notes on second screen=right" \
		-V beamertemplate:"{note page}[plain]" \
		-V classoption:aspectratio=169 -t beamer -o $@ $<