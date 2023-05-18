.PHONY: build lint test-unit test-functional test

build:
	docker build -t remind101/stacker .

lint:
	flake8 --ignore E402,W503,W504,W605,N818 --exclude stacker/tests/ stacker
	flake8 --ignore E402,N802,W605,N818 stacker/tests # ignore setUp naming

test-unit: clean
	python setup.py test

test-unit3: clean
	python3 setup.py test

clean:
	rm -rf .egg stacker.egg-info

test-functional:
	cd tests && bats test_suite

# General testing target for most development.
test: lint test-unit test-unit3

apidocs:
	sphinx-apidoc --force -o docs/api stacker
