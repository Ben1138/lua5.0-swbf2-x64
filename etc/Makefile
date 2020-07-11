# makefile for Lua etc

LUA= ..

include $(LUA)/config

LIBLUA=$(LIB)/liblua.a
ALL= bin2c min trace noparser luab

all:
	@echo 'choose a target:' $(ALL)

bin2c:	bin2c.c
	$(CC) $(CFLAGS) -o $@ $@.c

min:	min.c $(LIBLUA)
	$(CC) $(CFLAGS) -o $@ $@.c -L$(LIB) -llua50

trace:	trace.c $(LIBLUA)
	$(CC) -g $(CFLAGS) -o $@ $@.c -L$(LIB) -llua50 $(EXTRA_LIBS)

noparser: noparser.c
	$(CC) $(CFLAGS) -I$(LUA)/src -o $@.o -c $@.c

luab:	noparser $(LIBLUA)
	cc -o $@ noparser.o $(LUA)/src/lua/lua.o -L$(LIB) -llua50 $(EXTRA_LIBS)
	$(BIN)/luac $(LUA)/test/hello.lua
	$@ luac.out
	-$@ -e'a=1'

flat:
	cd ..; mkdir flat; mv include/*.h src/*.[ch] src/*/*.[ch] flat

$(LIBLUA):
	cd ../src; $(MAKE)

clean:
	rm -f $(ALL) a.out core *.o luac.out
