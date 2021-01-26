SRC_FILES := $(shell find src -name '*.sh' -o -name '*.png')
TARGET_FILES := $(SRC_FILES:src/%=dist/%)

dist: dist/next-wakeup ${TARGET_FILES}

dist/%: src/%
	@echo "Copying $<"
	@mkdir -p $(@D)
	@cp "$<" "$@"

dist/next-wakeup: src/next-wakeup/src/**/*.rs
	cd src/next-wakeup && cross build --release --target arm-unknown-linux-musleabi
	cp src/next-wakeup/target/arm-unknown-linux-musleabi/release/next-wakeup dist/

clean:
	find dist ! -name 'ht' ! -name next-wakeup -type f -exec rm {} +

watch:
	watchexec -w src/ -p -- make

.PHONY: clean watch
