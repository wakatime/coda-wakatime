# coda-wakatime

[![wakatime](https://wakatime.com/badge/github/wakatime/coda-wakatime.svg)](https://wakatime.com)

Coda plugin to generate metrics from your programming activity.

## Installation

1. Go to the [offical plugin page](https://panic.com/coda/plugins.php?id=139) then click `Install`

2. Enter your [api key](https://wakatime.com/settings#apikey), then click `OK`.

3. Use Coda like you normally do and your time will be tracked for you automatically.

4. Visit https://wakatime.com to see your logged time.

## Screen Shots

![Project Overview](https://wakatime.com/static/img/ScreenShots/ScreenShot-2014-10-29.png)

## Troubleshooting

First, try running this Terminal command:

```
rm -rf "~/Library/Application Support/Coda 2/Plug-ins/WakaTime.codaplugin/Contents/Resources/wakatime-master"
```

Then restart Coda.

If that doesn't work, turn on debug mode and check your Coda log file (`/var/log/system.log`) and your wakatime cli log file (`~/.wakatime/wakatime.log`).

For more general troubleshooting information, see [wakatime/wakatime#troubleshooting](https://github.com/wakatime/wakatime#troubleshooting).
