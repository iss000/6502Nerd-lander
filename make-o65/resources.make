clean +=

.PHONY: res-xxx
res += res-xxx
res-xxx:
	$(Q) true

# toolchain := $(shell echo $(TOOLCHAIN) | tr A-Z a-z)
.PHONY: release
release: clean all
	$(Q) [ -d ../BUILD ] || mkdir -p ../BUILD
	$(Q) cp -f bin/lander.tap ../BUILD/LANDER-$(TOOLCHAIN).tap
