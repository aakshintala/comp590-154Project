ARCH=riscv64-unknown-linux-gnu-
CC=$(ARCH)gcc
LD=$(ARCH)ld
OBJDUMP=$(ARCH)objdump
CFLAGS=-march=rv64im -mabi=lp64 -O0 -Wno-implicit-int
STRIP=$(ARCH)strip

OBJECT_FILES=prog1 prog2 prog3 prog4 prog5 test

.PHONY: all clean

all: $(OBJECT_FILES)

clean:
	rm -f $(OBJECT_FILES) $(patsubst %,%.o,$(OBJECT_FILES)) $(patsubst %,%.s,$(OBJECT_FILES))

prog5: $(wildcard sjeng/*.c)
	$(CC) $(CFLAGS) --static -o $@ $^
	$(OBJDUMP) -S $@ > $@.s

%: %.c
	$(CC) $(CFLAGS) --static -o $@ $<
	$(OBJDUMP) -S $@ > $@.s