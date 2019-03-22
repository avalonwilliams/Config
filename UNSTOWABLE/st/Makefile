# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c
OBJ = $(SRC:.c=.o)

all: options st man

options:
	@echo st build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h st.h win.h

$(OBJ): config.h config.mk

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f st $(OBJ) st.1 st-$(VERSION).tar.gz

dist: clean man
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h st.info st.1 st.1.pre arg.h st.h win.h st.desktop $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st-$(VERSION).tar.gz
	rm -rf st-$(VERSION)

man:
	m4 -DVERSION=$(VERSION) st.1.pre > st.1

install: st man
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 st $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(MANPREFIX)/man1
	install -m 644 st.1 $(DESTDIR)$(PREFIX)/man1
	tic -sx st.info
	@echo Please see the README file regarding the terminfo entry of st.
	install -d $(DESTDIR)$(PREFIX)/share/applications
	install -m 644 st.desktop $(DESTDIR)$(PREFIX)/share/applications

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st.1

.PHONY: all man options clean dist install uninstall
