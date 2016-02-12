
all:
	@echo "kura.snap: make all"
install:
	sh ./bin/install.sh ${DESTDIR}
clean:
	sh ./bin/clean.sh
