# Re-Packaging flatbuffers latest version for Debian Buster

* packaging source repo: https://salsa.debian.org/debian/flatbuffers
* target environment: Debian Buster (10.x), with `buster-backports` package repository enabled
* update period: weekly, if not updated or github actions reports error, you may want to open PR/issues

## Usage

```Dockerfile
FROM bbsdocker/debian_flatc:latest
```

## License

* MIT
