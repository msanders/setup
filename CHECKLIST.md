Manual steps that are still done on every new setup:

1. Run `~/.dotfiles/zero/setup`.
2. Restart once completed (and as-needed for system updates done by the script).
3. Rotate or import GPG keys.
4. Rotate or import SSH keys.
5. Import software licenses.
6. Copy various documents from backup; login to applications.

Then, in no particular order:

- System Preferences > Keyboard > Key Repeat > Fast.

- System Preferences > Keyboard > Delay Until Repeat > Short.

- System Preferences > Keyboard > Modifier Keys... > Caps Lock Key > Control.

- System Preferences > Display > Night Shift > Schedule > Sunset to Sunrise.

- System Preferences > Display > Night Shift > Color Temperature > More Warm
  (max).

- System Preferences > Language & Region > Time format > 24-Hour Time.

- System Preferences > GPG Suite > Remember for 86400.

- Change login shell to `/usr/local/bin/fish` via System Preferences > Users &
  Groups > Current User > Advanced Options (right click) > Login shell.

- Change system colors under System Preferences > General > Access Color &
  Highlight Color.

- Turn off font smoothing under System Preferences > General > Use font
  smoothing when available.

- Turn off System Preferences > Spotlight > Allow Spotlight Suggestions in Look
  up.

- Turn off various categories in System Preferences > Spotlight > Search
  Results.

- Turn off Messages > Edit > Substitutions > Emoji.

- Turn off Firefox > Preferences > Privacy & Security > Firefox Data Collection
  and Use > Allow Firefox to install and run studies.

- Turn on Firefox > Preferences > Privacy & Security > Prevent accessibility
  services from accessing your browser.

- Set host name under System Preferences > Sharing > Computer Name.

- Mail > Preferences > Composing > Message Format: Plain Text.

- Firefox > View > Toolbars > Customize... > Density > Compact.

- Firefox > Preferences > Privacy & Security > History > Firefox Will > Use
  custom settings for history.

- Firefox > Preferences > Privacy & Security > History > Remember search and
  form history > false.

- Firefox > about:config > `layout.css.osx-font-smoothing.enable` > false.

- Firefox > about:config > `dom.event.clipboardevents.enabled` > false.

- Flux > Preferences > Sunset > Normal/Daylight. (I use Night Shift for sunset,
  and Flux for "Bedtime".)

- Flux > Preferences > Bedtime > 1200K (max).

- Edit `/etc/pam.d/sudo` and add the following as the first two lines to enable
  [PAM Touch ID](https://github.com/Reflejo/pam-touchID) and [PAM Watch
  ID](https://github.com/biscuitehh/pam-watchid):

```
auth sufficient pam_touchid.so "reason=execute a command as root"
auth sufficient pam_watchid.so "reason=execute a command as root"
```

Some of these are preferably not automated, others weren't possible AFAICT.
