SHELL:=bash -e -o pipefail

default: prd

$(GOPATH)/bin/minify:
	go get github.com/tdewolff/minify/cmd/minify

prd: $(GOPATH)/bin/minify
	hugo
	for ft in html css xml; do \
		for f in $$(find docs -type f -name "*.$$ft"); do \
			echo "==> minifying $$f"; \
			minify $$f > $$f.tmp; \
			mv $$f{.tmp,}; \
		done; \
	done
