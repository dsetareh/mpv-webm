# custom mpv-webm
my improved version of https://github.com/ekisu/mpv-webm

| [Download Script](https://github.com/dsetareh/mpv-webm/releases/download/latest/webm.lua) | [Download Config](https://github.com/dsetareh/mpv-webm/releases/download/latest/webm.conf)|
| ----------- | ----------- |

- renames `avc` and `avc-nvenc` preset back to `mp4` and `mp4-nvenc`
- various `mp4-nvenc` fixes
    - actually works now
    - crf works too
- adds `mp4-compat` preset for compatibility with older devices
- osd revamp
    - shows output video length
    - shows source video height and fps
    - shows output video height and fps
    - less useless text (you'll need to memorize the keybinds)
    - cleaned up options page
- more output fps and resolution options (900p, 144fps, 5fps, etc...)
- other minor changes

<img src="/img/main_osd.png" alt="Main UI Example" width="600px"/>
