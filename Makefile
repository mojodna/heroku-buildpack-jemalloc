default: dist/jemalloc-4.2.1-1.tar.gz

dist/jemalloc-4.2.1-1.tar.gz: jemalloc-cedar
	docker cp $<:/tmp/jemalloc-cedar.tar.gz .
	mkdir -p $$(dirname $@)
	mv jemalloc-cedar.tar.gz $@

clean:
	rm -rf src/ dist/
	-docker rm jemalloc-cedar

src/jemalloc.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL https://github.com/jemalloc/jemalloc/releases/download/4.2.1/jemalloc-4.2.1.tar.bz2 -o $@

.PHONY: jemalloc-cedar

jemalloc-cedar: src/jemalloc.tar.bz2
	docker build --rm -t mojodna/$@ .
	-docker rm $@
	docker run --name $@ mojodna/$@ /bin/echo $@
