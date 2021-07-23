OUTPUT = $(shell grep 'output_directory' ${FILE}|cut -d '"' -f 2)
OUTPUT_FILE = $(shell ls ${OUTPUT}) 

all: prepare test build
	@echo "Packer build finished - image: ./${OUTPUT}/${OUTPUT_FILE}"

.PHONY: prepare
prepare:
	@echo "current packer version:" && packer --version || echo "packer not installed"
	@packer init ${FILE} && echo "missing plugins or upgrade installed"

.PHONY: test
test:
	@packer fmt --var-file=${VARS} ${FILE}
	@packer validate --var-file=${VARS} ${FILE} && echo "template is valid"

.PHONY: build
build:
	@packer build --var-file=${VARS} ${FILE}

.PHONY: clean
clean:
	@rm -rf output_*
	@rm -rf packer_cache
	@echo "cleanup finished!"