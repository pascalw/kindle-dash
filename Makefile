VERSION := v1.0.0-beta.4
SRC_FILES := $(shell find src -name '*.sh' -o -name '*.png')
NEXT_WAKEUP_SRC_FILES := $(shell find src/next-wakeup/src -name '*.rs')
TARGET_FILES := $(SRC_FILES:src/%=dist/%)

# Kindle scp params
REMOTE_HOST := root@192.168.3.103
REMOTE_DIR := /mnt/us/dashboard/
PORT := 2222

help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
	        sub(":", "", $$1); \
	        print "  " $$1 \
	    }' Makefile

dist: dist/next-wakeup dist/xh dist/local/state ${TARGET_FILES}

tarball: dist
	tar -C dist -cvzf kindle-dash-${VERSION}.tgz ./

dist/%: src/%
	@echo "Copying $<"
	@mkdir -p $(@D)
	@cp "$<" "$@"

dist/next-wakeup: ${NEXT_WAKEUP_SRC_FILES}
	cd src/next-wakeup && cross build --release --target arm-unknown-linux-musleabi
	cp src/next-wakeup/target/arm-unknown-linux-musleabi/release/next-wakeup dist/

dist/xh: tmp/xh
	cd tmp/xh && cross build --release --target arm-unknown-linux-musleabi
	docker run --rm \
		-v $(shell pwd)/tmp/xh:/src \
		rustembedded/cross:arm-unknown-linux-musleabi-0.2.1 \
		/usr/local/arm-linux-musleabi/bin/strip /src/target/arm-unknown-linux-musleabi/release/xh
	cp tmp/xh/target/arm-unknown-linux-musleabi/release/xh dist/

tmp/xh:
	mkdir -p tmp/
	git clone --depth 1 --branch v0.16.1 https://github.com/ducaale/xh.git tmp/xh

dist/local/state:
	mkdir -p dist/local/state

clean:
	rm -r dist/*

watch:
	watchexec -w src/ -p -- make

format:
	shfmt -i 2 -w -l src/**/*.sh

.PHONY: clean watch tarball format

# KOReader's ssh server will always ask for prompt even with password disabled, so we use expect to send an enter.
push-files:
	@echo "Usage: make scp source_files=<source_files>"
	@echo "       Transfer files to remote host using scp"
	expect -c 'spawn scp -P $(PORT) $(source_files) $(REMOTE_HOST):$(REMOTE_DIR); expect "*assword:" { send "\r" }; interact'

ssh:
	expect -c 'spawn ssh -p $(PORT) $(REMOTE_HOST); expect "*assword:" { send "\r" }; expect "# " { send "cd $(REMOTE_DIR)\r" }; interact'


get-logs:
	expect -c 'spawn scp -P $(PORT) $(REMOTE_HOST):$(REMOTE_DIR)/logs/*.log ./logs; expect "*assword:" { send "\r" }; interact'