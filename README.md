# OpenWRT Auto IPSet

Automatically download IP list from Internet and install it as IPSet.

## Usage

- Copy `auto-ipset.sh` to `/root/auto-ipset.sh` on your OpenWRT router.
- Copy `auto-ipset` to `/etc/init.d/auto-ipset` on your OpenWRT router.
- Run `/etc/init.d/auto-ipset start` to start script.
- Run `/etc/init.d/auto-ipset enable` to run script automatically on startup.

## Configuration

Edit `auto-ipset` to change the IPSet name and the IP list URL.

The default config creates an IPSet `btn` with the IP list from https://github.com/PBH-BTN/BTN-Collected-Rules

## License

Public domain.
