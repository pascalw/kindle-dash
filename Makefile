SRC_FILES := $(shell find src -name '*.sh' -o -name '*.png')
HT_SRC_FILES := $(shell find src/third_party/ht/src -name '*.rs')
TARGET_FILES := $(SRC_FILES:src/%=dist/%)

dist: dist/next-wakeup dist/ht dist/local/state ${TARGET_FILES}

tarball: dist
	tar -C dist -cvzf kindle-dash-${VERSION}.tgz ./

dist/%: src/%
	@echo "Copying $<"
	@mkdir -p $(@D)
	@cp "$<" "$@"

dist/next-wakeup: src/next-wakeup/src/**/*.rs
	cd src/next-wakeup && cross build --release --target arm-unknown-linux-musleabi
	cp src/next-wakeup/target/arm-unknown-linux-musleabi/release/next-wakeup dist/

dist/ht: ${HT_SRC_FILES}
	cd src/third_party/ht && cross build --release --target arm-unknown-linux-musleabi
	docker run --rm \
		-v $(shell pwd)/src/third_party/ht:/src \
		rustembedded/cross:arm-unknown-linux-musleabi-0.2.1 \
		/usr/local/arm-linux-musleabi/bin/strip /src/target/arm-unknown-linux-musleabi/release/ht
	cp src/third_party/ht/target/arm-unknown-linux-musleabi/release/ht dist/

dist/local/state:
	mkdir dist/local/state

clean:
	rm -r dist/*

watch:
	watchexec -w src/ -p -- make

.PHONY: clean watch tarball
