VERSION      = 0.1.2
BINARY      = terraform-provider-uptimerobot_v${VERSION}_x4
GOARCH      = amd64
CURRENT_DIR = $(shell pwd)
LDFLAGS     = -ldflags "-X main.VERSION=${VERSION}"
OS          = $(shell uname | awk '{print tolower($$0)}')
OS_ARCH     = ${OS}_amd64

# Build the project
all: build publish clean

build:
	cd ${CURRENT_DIR}; \
	go get -v ...
	GOOS=${OS} GOARCH=${GOARCH} CGO_ENABLED=0 go build ${LDFLAGS} -o ${BINARY} . ; \

clean:
	rm -f terraform-provider-uptimerobot_*

publish:
	test -n "$(NEXUS_USERNAME)"  # $$NEXUS_USERNAME
	test -n "$(NEXUS_PASSWORD)"  # $$NEXUS_PASSWORD
	test -n "$(NEXUS_URL)"  		 # $$NEXUS_URL
	tar czvf ${BINARY}.tar.gz ${BINARY}
	curl -v --user "${NEXUS_USERNAME}:${NEXUS_PASSWORD}" --upload-file ${BINARY}.tar.gz "${NEXUS_URL}/repository/terraform-providers/${BINARY}.tar.gz"

.PHONY: linux clean
