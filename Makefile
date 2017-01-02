PWD := $(shell pwd)
NAME := $(shell basename ${PWD})

all: rpm

help:
	@echo "makefile"
	@echo
	@echo "Builds:"
	@echo "  make rpm           Build the rpm package"
	@echo

rpm:
	docker build . -t ${NAME}:latest
	docker run --rm -ti -v ${PWD}/RPMS:/RPMS ${NAME}:latest

rpm5:
	docker build . --file Dockerfile.el5 -t ${NAME}:latest
	docker run --rm -ti -v ${PWD}/RPMS:/RPMS ${NAME}:latest
