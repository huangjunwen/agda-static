# agda-static

Images with static built agda binaries and stdlib

## Versions

| Agda Version | Agda Stdlib Version |
| :---: | :---: |
| v2.7.0.1 | v2.2 |

## Portable

All files are installed under `/agda` folder in the image:

- `/agda/bin`: contains static built binaries and some helper scripts
- `/agda/share/agda/data`: contains required builtin files, one should set environment variable `Agda_datadir` to this folder
- `/agda/share/agda/libs`: contains libraries
- `/agda/etc/agda`: contains generated `libraries` and `defaults` files, one should set environment variable `AGDA_DIR` to this folder if want to use them

You can extract it anywhere to your host like:

```
podman unshare bash -c 'mnt=$(podman image mount ghcr.io/huangjunwen/agda-static:2.6.4.3); cp -r $mnt/agda .'
```

## Links

- https://github.com/agda/agda
- https://github.com/agda/agda-stdlib
- https://wiki.portal.chalmers.se/agda/Libraries/StandardLibrary
