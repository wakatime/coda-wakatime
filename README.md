coda-wakatime
=============

Coda plugin to generate metrics from your programming activity.


Installation
------------

1. Download the plugin.

2. Double click on `WakaTime.codaplugin`

3. Enter your [api key](https://wakatime.com/settings#apikey), then click `OK`.

4. Use Coda like you normally do and your time will be tracked for you automatically.

5. Visit https://wakatime.com to see your logged time.


Screen Shots
------------

![Project Overview](https://wakatime.com/static/img/ScreenShots/ScreenShot-2014-10-29.png)


Troubleshooting
---------------

First, try running this Terminal command:

```
rm -rf "~/Library/Application Support/Coda 2/Plug-ins/WakaTime.codaplugin/Contents/Resources/wakatime-master"
```

Then restart Coda.

If that doesn't work, turn on debug mode and check your Coda log file (`/var/log/system.log`) and your wakatime cli log file (`~/.wakatime.log`).

For more general troubleshooting information, see [wakatime/wakatime#troubleshooting](https://github.com/wakatime/wakatime#troubleshooting).
