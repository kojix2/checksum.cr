# checksum

[![test](https://github.com/kojix2/checksum.cr/actions/workflows/test.yml/badge.svg)](https://github.com/kojix2/checksum.cr/actions/workflows/test.yml)

Make `md5sum -c` or `sha256sum -c` prettier.

## Installation

```sh
git clone https://github.com/kojix2/checksum.cr
cd checksum
shards build --release
cp bin/checksum /usr/local/bin/
```

## Usage

```sh
checksum -c md5sum.txt
```

```
Usage: checksum [options]
    -c, --check FILE                 Read checksums from the FILE (required)
    -a, --algorithm ALGORITHM        (md5|sha1|sha256|sha512) [auto]
    -A, --absolute                   Output absolute path [false]
    -v, --verbose                    Verbose mode for outputting checksums and errors.
    --no-clear                       Do not clear the line [false]
    --no-color                       Do not use color [false]
    --debug                          Debug mode [false]
    -h, --help                       Show this message
    --version                        Show version
```

### Experimental multi-threading support (preview)

This feature may not work properly.

```sh
git clone https://github.com/kojix2/checksum.cr
cd checksum
shards build --release -Dpreview_mt
cp bin/checksum /usr/local/bin/
CRYSTAL_WORKERS=2 checksum -c md5sum.txt
```

## Development

Pull requests are welcome.

## License

MIT
