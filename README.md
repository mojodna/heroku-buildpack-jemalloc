# heroku-buildpack-jemalloc

I am a Heroku buildpack that installs
[jemalloc](http://www.canonware.com/jemalloc/) into a dyno slug.

## Unmaintained :wave:

This Heroku buildpack is no longer actively maintained. It should continue to
work but won't see changes as updates to Heroku or jemalloc are released.

Consider switching to [gaffneyc/heroku-buildpack-jemalloc](https://github.com/gaffneyc/heroku-buildpack-jemalloc/)
if you run into problems or want to try a [newer release of jemalloc](https://github.com/jemalloc/jemalloc/releases).

## Using

To use jemalloc with your app, either prefix commands with `jemalloc.sh <cmd>`
or set `LD_PRELOAD=/app/vendor/jemalloc/lib/libjemalloc.so.1` in your
environment (it will then apply to all commands run).

Example, in your Procfile:

```
web: jemalloc.sh bundle exec puma -C config/puma.rb
```

Setting LD_PRELOAD can sometimes mess with the building of an app - if you're seeing errors during slug compilation, try removing LD_PRELOAD and just using `jemalloc.sh`.

### Composed

[Heroku now supports using multiple buildpacks for an app](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app).

```bash
heroku buildpacks:add --index 1 https://github.com/mojodna/heroku-buildpack-jemalloc.git
git push heroku master
```

If you're not seeing great results from Jemalloc 4.x, you can try Jemalloc 3.6 instead:

```bash
heroku buildpacks:add --index 1 https://github.com/mojodna/heroku-buildpack-jemalloc.git#v3.6.0
git push heroku master
```

Note that you can also use this syntax to lock your buildpack to a specific release.

## Building

This uses Docker to build against Heroku
[stack-image](https://github.com/heroku/stack-images)-like images.

```bash
make
```

Artifacts will be dropped in `dist/`.  See `Dockerfile`s for build options.
