# agda-static

Tiny image of static built agda binaries with libs.

## versions

| Agda Version | Agda Stdlib Version |
| :---: | :---: |
| v2.6.4.3 | v2.1 |

## Portable

All files are installed in `/agda-static` folder and it's also portable, you can extract it anywhere to your host like:

```
podman unshare bash -c 'mnt=$(podman image mount ghcr.io/huangjunwen/agda-static:amd64-v2.6.4.3); cp -r $mnt/agda-static .; rm -rf agda-static/etc/agda/*'
```

NOTE: the `rm` part is to remove `libraries` and `defaults` files, it will be re-generated next time you run `agda` or `agda-mode` and collect
all the libraries put to `agda-static/share/agda/libs` folder (so you can download your fav libs there)

## links

- https://github.com/agda/agda
- https://github.com/agda/agda-stdlib
- https://wiki.portal.chalmers.se/agda/Libraries/StandardLibrary
