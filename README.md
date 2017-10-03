# heroku-buildpack-jemalloc

I am a Heroku buildpack that installs
[jemalloc](http://www.canonware.com/jemalloc/) into a dyno slug.

## Install

[Heroku supports using multiple buildpacks for an app](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app).

```bash
heroku buildpacks:add --index 1 https://github.com/mojodna/heroku-buildpack-jemalloc.git
git push heroku master
```

## Usage

After you've added the buildpack, to use jemalloc with your app, prefix commands with `jemalloc.sh <cmd>`:

```
web: jemalloc.sh bundle exec puma -C config/puma.rb
```

You can also use the environment variable LD_PRELOAD to replace `malloc` in all processes with `jemalloc`:

```
LD_PRELOAD=`jemalloc-config --libdir`/libjemalloc.so.`jemalloc-config --revision`
```

Setting LD_PRELOAD can sometimes mess with the building of an app - if you're seeing errors during slug compilation, try removing LD_PRELOAD and just using `jemalloc.sh`.

## Other JEMalloc versions

You can point to a specific tag to lock to a specific version of jemalloc. To see all available versions, see the [releases page.](https://github.com/mojodna/heroku-buildpack-jemalloc/releases)

```bash
heroku buildpacks:add --index 1 https://github.com/mojodna/heroku-buildpack-jemalloc.git#v3.6.0
git push heroku master
```

## Building

This uses Docker to build against Heroku
[stack-image](https://github.com/heroku/stack-images)-like images.

```bash
make
```

Artifacts will be dropped in `dist/`.  See `Dockerfile`s for build options.
