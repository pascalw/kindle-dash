SRC_FILES := $(shell find src -name '*.sh' -o -name '*.png')
NEXT_WAKEUP_SRC_FILES := $(shell find src/next-wakeup/src -name '*.rs')
TARGET_FILES := $(SRC_FILES:src/%=dist/%)

dist: dist/next-wakeup dist/ht dist/local/state ${TARGET_FILES}

tarball: dist
	tar -C dist -cvzf kindle-dash-${VERSION}.tgz ./

dist/%: src/%
	@echo "Copying $<"
	@mkdir -p $(@D)
	@cp "$<" "$@"

dist/next-wakeup: ${NEXT_WAKEUP_SRC_FILES}
	cd src/next-wakeup && cross build --release --target arm-unknown-linux-musleabi
	cp src/next-wakeup/target/arm-unknown-linux-musleabi/release/next-wakeup dist/

dist/ht: tmp/ht
	cd tmp/ht && cross build --release --target arm-unknown-linux-musleabi
	docker run --rm \
		-v $(shell pwd)/tmp/ht:/src \
		rustembedded/cross:arm-unknown-linux-musleabi-0.2.1 \
		/usr/local/arm-linux-musleabi/bin/strip /src/target/arm-unknown-linux-musleabi/release/ht
	cp tmp/ht/target/arm-unknown-linux-musleabi/release/ht dist/

tmp/ht:
	mkdir -p tmp/
	git clone --depth 1 --branch v0.4.0 https://github.com/ducaale/ht.git tmp/ht

dist/local/state:
	mkdir dist/local/state

clean:
	rm -r dist/*

watch:
	watchexec -w src/ -p -- make

format:
	shfmt -i 2 -w -l src/**/*.sh

.PHONY: clean watch tarball format
