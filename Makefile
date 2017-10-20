.PHONY: all build push

VERSION_STABLE  := $(shell curl -sSL http://www.ubnt.com/downloads/unifi/debian/dists/stable/ubiquiti/binary-armhf/Packages.gz  | zgrep Version | sed -rn 's/Version: ([[:digit:]].[[:digit:]].[[:digit:]]+)-.*/\1/p')
VERSION_TESTING := $(shell curl -sSL http://www.ubnt.com/downloads/unifi/debian/dists/testing/ubiquiti/binary-armhf/Packages.gz | zgrep Version | sed -rn 's/Version: ([[:digit:]].[[:digit:]].[[:digit:]]+)-.*/\1/p')

all: build-stable push-stable build-testing push-testing
stable: build-stable push-stable
testing: build-testing push-testing

build-stable:
	@docker build --no-cache --pull --build-arg suite=stable -t johannrichard/unifi-armhf:unifi5 -t johannrichard/unifi-armhf:stable -t johannrichard/unifi-armhf:latest -t johannrichard/unifi-armhf:${VERSION_STABLE} .

push-stable:
	@docker push johannrichard/unifi-armhf:unifi5
	@docker push johannrichard/unifi-armhf:stable
	@docker push johannrichard/unifi-armhf:latest
	@docker push johannrichard/unifi-armhf:${VERSION_STABLE}

build-testing:
	@docker build --no-cache --pull --build-arg suite=testing -t johannrichard/unifi-armhf:testing -t johannrichard/unifi-armhf:${VERSION_TESTING} .

push-testing:
	@docker push johannrichard/unifi-armhf:testing
	@docker push johannrichard/unifi-armhf:${VERSION_TESTING}
