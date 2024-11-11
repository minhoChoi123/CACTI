TAR = cacti

.PHONY: gdb opt depend clean clean_gdb clean_opt

all: gdb

gdb: $(TAR).mk obj_gdb
	@$(MAKE) TAG=gdb -C . -f $(TAR).mk

opt: $(TAR).mk obj_opt
	@$(MAKE) TAG=opt -C . -f $(TAR).mk

obj_gdb:
	mkdir $@

obj_opt:
	mkdir $@

clean: clean_gdb clean_opt

clean_gdb: obj_gdb
	@$(MAKE) TAG=gdb -C . -f $(TAR).mk clean
	rm -rf $<

clean_opt: obj_opt
	@$(MAKE) TAG=opt -C . -f $(TAR).mk clean
	rm -rf $<

