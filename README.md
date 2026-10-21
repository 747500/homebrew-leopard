# homebrew-leopard

Tigerbrew formulae fixed for Mac OS X 10.5 Leopard (PowerPC).

    brew tap 747500/leopard
    brew tap-pin 747500/leopard   # prefer these over core formulae with the same name

## openssh

Same as the core formula, plus:

- `--with-privsep-user=_sshd`. On Leopard the user is `_sshd`, and Apple's sshd is built with it; `sshd` is only a DirectoryService alias.
- A launchd plist in inetd mode (`sshd -i` per connection, `SessionCreate`), like Apple's `com.openssh.sshd`. A long-running `sshd -D` under launchd breaks on Leopard: the first login works, but after it `pam_open_session()` fails and every session exits with 254.

Replacing Apple's sshd:

    sudo launchctl unload -w /System/Library/LaunchDaemons/ssh.plist
    sudo cp -fv /usr/local/opt/openssh/*.plist /Library/LaunchDaemons
    sudo launchctl load -w /Library/LaunchDaemons/tigerbrew.mistydemeo.openssh.plist

In `/usr/local/etc/ssh/sshd_config` set `UsePAM yes`. Put `HostKey /etc/ssh_host_rsa_key` first, so clients' known_hosts stay valid.

`brew upgrade openssh` removes the keg for the whole build, about 12 minutes on a G4. New ssh connections are refused until the build finishes, so keep a session open.

## rsync

Same as the core formula, with the download URLs fixed. The tarballs are under `.../pub/rsync/src/`, and the old URL and both mirrors return 404.

## smartmontools

Version 6.6 instead of 7.x. Starting with 7.0, smartmontools needs C++11, and Xcode 3.1 has only gcc 4.0/4.2; 6.6 still builds as C++98. Tested on a Mac mini G4: `smartctl -A /dev/disk0` reads SMART from the internal ATA disk, including temperature.
