# heroku-buildpack-jemalloc

I am a Heroku buildpack that installs
[jemalloc](http://www.canonware.com/jemalloc/) into a dyno slug.

When used with
[heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi),
I enable subsequent buildpacks / steps to link to this library.  (You'll
need to use the `build-env` branch of [@mojodna's
fork](https://github.com/mojodna/heroku-buildpack-multi/tree/build-env) for the
build environment (`CPATH`, `LIBRARY_PATH`, etc.) to be set correctly.)

## Using

To use jemalloc with your app, either prefix commands with `jemalloc.sh <cmd>`
or set `LD_PRELOAD=/app/vendor/jemalloc/lib/libjemalloc.so.1` in your
environment (it will then apply to all commands run).

### Composed

You'll almost certainly want to use this in conjunction with one or more
additional buildpack.

When creating a new Heroku app:

```bash
heroku apps:create -b https://github.com/mojodna/heroku-buildpack-multi.git#build-env

cat << EOF > .buildpacks
https://github.com/mojodna/heroku-buildpack-jemalloc.git
https://github.com/heroku/heroku-buildpack-nodejs.git
EOF

git push heroku master
```

When modifying an existing Heroku app:

```bash
heroku config:set BUILDPACK_URL=https://github.com/mojodna/heroku-buildpack-multi.git#build-env

cat << EOF > .buildpacks
https://github.com/mojodna/heroku-buildpack-jemalloc.git
https://github.com/heroku/heroku-buildpack-nodejs.git
EOF

git push heroku master
```

## Building

jemalloc was built in a [cedar stack
image](https://github.com/heroku/stack-images) using the following steps.

`chroot` preparation:

```bash
mkdir app tmp
sudo /vagrant/bin/install-stack cedar64-2.0.0.img.gz
sudo mount -o bind /dev /mnt/stacks/cedar64-2.0.0/dev/
sudo mount -o bind /home/vagrant/tmp /mnt/stacks/cedar64-2.0.0/tmp/
sudo mount -o bind /home/vagrant/app /mnt/stacks/cedar64-2.0.0/app/
```

jemalloc build/package:

```bash
cd tmp/
curl -LO http://www.canonware.com/download/jemalloc/jemalloc-3.4.0.tar.bz2
sudo chroot /mnt/stacks/cedar64-2.0.0
cd /tmp
tar jxf jemalloc-3.4.0.tar.bz2
cd jemalloc-3.4.0
./configure --prefix=/app/vendor/jemalloc
make -j4
make install_bin install_include install_lib_shared install_lib_static
cd /app/vendor/jemalloc
tar zcf /tmp/jemalloc-3.4.0-1.tar.gz .
```
