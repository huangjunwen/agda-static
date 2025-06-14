# agda-static

Tiny image of static built agda binaries with libs.

## Versions

| Agda Version | Agda Stdlib Version |
| :---: | :---: |
| v2.6.4.3 | v2.1 |

## Portable

All files are installed under `/agda-static` folder in the image.

And it's also portable, you can extract it anywhere to your host like:

```
podman unshare bash -c 'mnt=$(podman image mount ghcr.io/huangjunwen/agda-static:amd64-v2.6.4.3); cp -r $mnt/agda-static .; rm -rf agda-static/etc/agda/*'
```

NOTE: The `rm` part is to remove `libraries` and `defaults` files. 
They will be re-generated next time when you run `agda` or `agda-mode` again.
All libraries put to `agda-static/share/agda/libs` folder will be automatically added (so you can download your fav libs there)

## links

- https://github.com/agda/agda
- https://github.com/agda/agda-stdlib
- https://wiki.portal.chalmers.se/agda/Libraries/StandardLibrary
