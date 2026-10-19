.PHONY: check build test inventory
check:
	python3 tools/check_source.py
build:
	./build/build.sh
test:
	python3 -m pytest -q tests/unit
inventory:
	find src -type f | sort
