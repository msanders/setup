## Installation

Run this:

```sh
$ git clone --recursive https://github.com/msanders/setup ~/.dotfiles
$ caffeinate ~/.dotfiles/zero/setup
```

This will run the appropriate installers and symlink the contained files to your
home directory. Everything is configured and tweaked within `~/.dotfiles`.

**Note**: it may be necessary to log in to the App Store before running, as
`brew bundle` will invoke [`mas`](https://github.com/mas-cli/mas) which requires
it.

For a full list of steps done on new machines, see
[CHECKLIST.md](./CHECKLIST.md).

##

This repo uses [zero.sh](https://github.com/zero-sh/zero.sh) for system setup
and configuration.

Licensed under the MIT License, except where otherwise noted. See
[LICENSE](LICENSE) for more information.
