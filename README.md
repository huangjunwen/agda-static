# agda-static

Images with static built agda binaries and stdlib

## Versions

| Agda Version | Agda Stdlib Version |
| :---: | :---: |
| v2.7.0.1 | v2.2 |

## Portable

All files are installed under `/agda` folder in the image:

- `/agda/bin`: contains scripts
- `/agda/bin/static`: contains static built binaries
- `/agda/share/agda/data`: contains required builtin files, one should set environment variable `Agda_datadir` to this folder
- `/agda/share/agda/libs`: contains libs
- `/agda/etc/agda`: contains generated `libraries` and `defaults` files, one should set environment variable `AGDA_DIR` to this folder if want to use them

You can extract it anywhere to your host like:

```
podman unshare bash -c 'mnt=$(podman image mount ghcr.io/huangjunwen/agda-static:2.7.0.1); cp -r $mnt/agda agda-static'
```

Make sure to run `regist-agda-libraries` to gather `*.agda-lib` information after downloading new libraries into `agda-static/share/agda/libs`

## Links

- https://github.com/agda/agda
- https://github.com/agda/agda-stdlib
- https://wiki.portal.chalmers.se/agda/Libraries/StandardLibrary
