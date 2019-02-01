-include .env
export

start:
	nim c -r src/nim_jester.nim --verbose

install:
	nimble install jester
