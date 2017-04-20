# heroku-buildpack-jemalloc

I am a Heroku buildpack that installs
[jemalloc](http://www.canonware.com/jemalloc/) into a dyno slug.

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

## Building

This uses Docker to build against Heroku
[stack-image](https://github.com/heroku/stack-images)-like images.

```bash
make
```

Artifacts will be dropped in `dist/`.  See `Dockerfile`s for build options.
