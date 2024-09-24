start:
	bin/dev

setup:
	install
	db-prepare
	copy-env

install:
	bin/setup

db-prepare:
	bin/rails db:reset
	bin/rails db:fixtures:load

copy-env:
	cp -n .env.example .env || true

test:
	bin/rails test

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop -A

.PHONY: test
