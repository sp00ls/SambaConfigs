# SambaConfigs
Configs for a server running Samba V4 and ZFS. Automatically creates user share/time machine via linux users/groups and exposes a public share

# Server setup
I'm running Samba V4 on Debian 10. A ZFS filesystem is mounted on /tank. You'll want to manually create:
* /tank/user
* /tank/time_machine
* /tank/public

before getting started via `zfs add tank/user`, etc

Should look something like:
```
root@steel:~# zfs list
NAME                USED  AVAIL     REFER  MOUNTPOINT
tank                467G  7.36T      185K  /tank
tank/public         199K  7.36T      199K  /tank/public
tank/time_machine   414G  7.36T      414G  /tank/time_machine
tank/user          52.8G  7.36T      170K  /tank/user
```

`avahi-daemon` should be installed for Time Machine to pick up the share automatically, at least as of macOS 10.14.6. Copy the `timemachine.service` file to `/etc/avahi/services/` and restart the service. All other files go in `/etc/samba`

# User setup
Add Linux groups
* shares
* time_machine

and create your users. To allow the user `ken` to do time machine backups just add the user to the `time_machine` group. Same process for a user you want to have a private share, just with the `shares` group.

# Further info
The samba daemon will automatically add a ZFS dataset for each user's private share on their first login, under `tank/user/<username>`. This allows each user's dataset to be managed individually, for snapshots or quotas. The script also creates a symlink to the public share in the user's share.

Time machine backups are managed as a single dataset. I use the encryption built into time machine so I'm not sure ZFS snapshotting would do anything useful for me. The config does enforce each user into their own time machine directory though, so users can not see other user's backups.

The public share is publicly readable/writeable with no username/password.

These configs/scripts should hopefully help you get started quickly after minor changes to fit your specific environment.