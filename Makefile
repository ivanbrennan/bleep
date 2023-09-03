PROJECT_NAME ?= bleep
PROJECT_ROOT ?= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: build
build:
	nix develop --command bash -c "cabal v2-build --ghc-option=-Werror"

.PHONY: run
run:
	nix develop --command bash -c "cabal v2-run"

.PHONY: shell
shell:
	nix develop

.PHONY: clean
clean:
	rm -rf $(PROJECT_ROOT)/dist
	rm -rf $(PROJECT_ROOT)/dist-newstyle
	rm -f  $(PROJECT_ROOT)/.ghc.environment.*
	rm -f  $(PROJECT_ROOT)/result
