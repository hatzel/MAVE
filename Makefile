default: build run

build:
	zip -r MAVE.love main.lua gfx/ sfx/

run:
	love MAVE.love
