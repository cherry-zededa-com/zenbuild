# This is a bandaid Makefile to standin for the linuxkit one when / if we 
# pull it in.
# We scan for any file named kernel_config_* and set KERNEL_CUST_CONF to that
# filename. For each of these files, we then build a kernel in a corresponding
# target image.
# Bricks and bouqets to Cherry G. Mathew <cherry@zededa.com>

# Inherit from the parent build, if relevant.
BUILDARCH ?= $(shell uname -m) 

build: $(wildcard kernel_config-*-${BUILDARCH})
	docker build --no-cache -f Dockerfile --build-arg KERNEL_CUST_CONF=$? -t zededa/kernel:$? .

push:
forcepush:
forcebuild:
show-tag:
	@echo XXX: unimplemented - talk to gianluca about linuxkit equivalence

# XXX: How do we get rid of the intermediate images explicitly ?
clean: $(wildcard kernel_config-*-${BUILDARCH})
	docker image rm zededa/kernel:$?


all: build
