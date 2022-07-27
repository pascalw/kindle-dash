VERSION := v1.0.0-beta.4
SRC_FILES := $(shell find src -name '*.sh' -o -name '*.png')
NEXT_WAKEUP_SRC_FILES := $(shell find src/next-wakeup/src -name '*.rs')
TARGET_FILES := $(SRC_FILES:src/%=dist/%)

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
