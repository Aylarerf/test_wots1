CC = /usr/bin/gcc
CFLAGS = -Wall -g -O3 -Wextra -Wpedantic
LDLIBS = -lcrypto

SOURCES = params.c hash.c fips202.c hash_address.c randombytes.c wots.c utils.c
HEADERS = params.h hash.h fips202.h hash_address.h randombytes.h wots.h utils.h

SOURCES_FAST = $(subst xmss_core.c,xmss_core_fast.c,$(SOURCES))
HEADERS_FAST = $(subst xmss_core.c,xmss_core_fast.c,$(HEADERS))

TESTS = test/wots \

tests: $(TESTS)

test: $(TESTS:=.exec)

.PHONY: clean test

test/%.exec: test/%
	@$<

test/%: test/%.c $(SOURCES) $(OBJS) $(HEADERS)
	$(CC) $(CFLAGS) -o $@ $(SOURCES) $< $(LDLIBS)

clean:
	-$(RM) $(TESTS)
	-$(RM) test/vectors
	-$(RM) $(UI)
