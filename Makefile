.PHONY: clean build test coverage format analyze help

help:
	@echo "Available commands:"
	@echo "  clean     - Clean build directory"
	@echo "  build     - Build the application"
	@echo "  test      - Run tests"
	@echo "  coverage  - Run tests with coverage"
	@echo "  format    - Format code"
	@echo "  analyze   - Analyze code"
	@echo "  gen       - Run code generation"
	@echo "  upgrade   - Upgrade dependencies"
	@echo "  doctor    - Run Flutter doctor"

clean:
	flutter clean

build:
	flutter pub get
	flutter build windows
	flutter build macos
	flutter build linux

test:
	flutter test

coverage:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html

format:
	dart format lib test

analyze:
	flutter analyze

gen:
	flutter pub run build_runner build --delete-conflicting-outputs

upgrade:
	flutter pub upgrade

doctor:
	flutter doctor -v