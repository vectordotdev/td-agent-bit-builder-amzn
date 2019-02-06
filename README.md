# td-agent-builder-azmn

Contains configuration to build [fluent-bit]() packages for Amazon Linux 1.

Largely based on [the CentOS 7 configuratio in
fluent-bit-packaging](https://github.com/fluent/fluent-bit-packaging/tree/master/distros/centos/7).

## Differences

The major difference is that a SysV-style init script is included in the package for running on Amazon Linux 1 which
lacks SystemD. This is accomplished through applying a patch before building (see `patches/`).

## Building

Run `./build.sh <version number>` to build a package that will be placed in `output/`.

When building a new version, a new patch file should be created if needed to add the SysV init script and configure
td-agent-bit to optionally daemonize (since the init script needs it to and the config file overrides command line
flags).

## Releasing

New versions should be uploaded to PackageCloud to be released.
