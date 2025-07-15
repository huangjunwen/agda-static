# agda-static

Images of static built agda binaries with libs.

## Versions

| Agda Version | Agda Stdlib Version |
| :---: | :---: |
| v2.6.4.3 | v2.1 |

## Portable

All files are installed under `/agda-static` folder in the image:

- `/agda-static/bin`: contains static built `agda` and `agda-mode` binaries
- `/agda-static/share/agda/data`: contains builtin data files required, one should set environment variable `Agda_datadir` to this folder
- `/agda-static/share/agda/libs`: contains libraries
- `/agda-static/etc/agda`: contains `libraries` and `defaults` files, one should set environment variable `AGDA_DIR` to this folder
- `/agda-static/opt/bin`: contains bash wrapper scripts for `agda` and `agda-mode`, which generate `libraries` and `defaults` files and set above environment variables automatically, you can put it in `PATH` for convenience

You can extract it anywhere to your host like:

```
podman unshare bash -c 'mnt=$(podman image mount ghcr.io/huangjunwen/agda-static:amd64-v2.6.4.3); cp -r $mnt/agda-static .'
```

## links

- https://github.com/agda/agda
- https://github.com/agda/agda-stdlib
- https://wiki.portal.chalmers.se/agda/Libraries/StandardLibrary
