## 5.0.0

* Update to jemalloc 5
* LD_PRELOAD now works differently. Previously, you could point it directly to the jemalloc shared library (/app/vendor/jemalloc/lib/libjemalloc.so.1). Now, it's better to let jemalloc do it for you, as noted in the README. You must change this environment variable when upgrading and it is not backwards compatible. If you are not using LD_PRELOAD and instead use jemalloc.sh, no action is required.
