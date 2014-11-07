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
heroku apps:create -b https://github.com/ddollar/heroku-buildpack-multi.git

cat << EOF > .buildpacks
https://github.com/mojodna/heroku-buildpack-jemalloc.git
https://github.com/heroku/heroku-buildpack-nodejs.git
EOF

git push heroku master
```

When modifying an existing Heroku app:

```bash
heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git

cat << EOF > .buildpacks
https://github.com/mojodna/heroku-buildpack-jemalloc.git
https://github.com/heroku/heroku-buildpack-nodejs.git
EOF

git push heroku master
```

## Building

This uses Docker to build against Heroku
[stack-image](https://github.com/heroku/stack-images)-like images.

```bash
make
```

Artifacts will be dropped in `dist/`.  See `Dockerfile`s for build options.
