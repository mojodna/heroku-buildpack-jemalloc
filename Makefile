default: cedar-14

cedar-14: dist/cedar-14/jemalloc-3.6.0-1.tar.gz

dist/cedar-14/jemalloc-3.6.0-1.tar.gz: jemalloc-cedar-14
	docker cp $<:/tmp/jemalloc-cedar-14.tar.gz .
	mkdir -p $$(dirname $@)
	mv jemalloc-cedar-14.tar.gz $@

clean:
	rm -rf src/ cedar*/*.sh dist/ jemalloc-cedar*/*.tar.*
	-docker rm jemalloc-cedar-14

src/jemalloc.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL http://www.canonware.com/download/jemalloc/jemalloc-3.6.0.tar.bz2 -o $@

.PHONY: cedar-14-stack

cedar-14-stack: cedar-14-stack/cedar-14.sh
	@(docker images -q mojodna/$@ | wc -l | grep 1 > /dev/null) || \
		docker build --rm -t mojodna/$@ $@

cedar-14-stack/cedar-14.sh:
	curl -sLR https://raw.githubusercontent.com/heroku/stack-images/master/bin/cedar-14.sh -o $@

.PHONY: jemalloc-cedar-14

jemalloc-cedar-14: cedar-14-stack jemalloc-cedar-14/jemalloc.tar.bz2
	docker build --rm -t mojodna/$@ $@
	-docker rm $@
	docker run --name $@ mojodna/$@ /bin/echo $@

jemalloc-cedar-14/jemalloc.tar.bz2: src/jemalloc.tar.bz2
	ln -f $< $@
