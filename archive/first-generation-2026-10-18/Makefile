# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Copyright (c) 2026 Ahmad Ali Parr. All rights reserved.
# Authored by Ahmad Ali Parr.
# Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE.

.PHONY: check build test inventory
check:
	python3 tools/check_source.py
build:
	./build/build.sh
test:
	python3 -m pytest -q tests/unit
inventory:
	find src -type f | sort
