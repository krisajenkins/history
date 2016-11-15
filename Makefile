all: .built

.built: $(shell find src -type f -name '*.elm' -o -name '*.js')
	elm-make --yes --warn | tee $@
