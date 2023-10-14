# asteroids_stats

A Lua plugin for [MAME](https://www.mamedev.org) that tracks Asteroids stats

## Instructions

1. Install the plugin files
    1. Go to your MAME installation directory and create a directory named asteroids_plugins in the plugins subdirectory.
    1. Copy the two files init.lua and plugin.json into the asteroids_plugins directory.
1. Enable this plugin. The usual way to do this is by editing the mame.ini file and adding 'asteroids_stats' to the plugin option.

Now that this enabled, the next time you play Asteroids, this plugin will run and emit information to the console.

**NOTE:** This only works for one player games!

## Output

This is the output that you will see.

**NOTE:** This doesn't have file or video frame output yet! 

```
rick@Mac:~/Projects/mame0258-x86 $ ./mame -window asteroid
ASTEROIDS: Stats Plugin On
Number of ships: 3
Number of asteroids: 4
Number of asteroids: 6
Number of asteroids: 8
Number of asteroids: 10
Number of asteroids: 9
Number of asteroids: 8
Number of asteroids: 7
Number of asteroids: 9
Number of asteroids: 8
Number of asteroids: 10
Number of asteroids: 12
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 11
Number of asteroids: 10
Number of asteroids: 9
Number of asteroids: 11
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 11
Number of asteroids: 10
Number of asteroids: 9
Number of asteroids: 8
Number of asteroids: 7
Number of asteroids: 6
Number of asteroids: 8
Number of asteroids: 7
Number of asteroids: 6
Number of asteroids: 5
Number of asteroids: 7
Number of asteroids: 6
Number of asteroids: 5
Number of asteroids: 4
Number of asteroids: 3
Number of asteroids: 2
Number of asteroids: 1
Number of asteroids: 0
waveCount: 2
Number of asteroids: 6
Number of asteroids: 8
Number of asteroids: 10
Number of asteroids: 12
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 11
Number of asteroids: 9
Number of asteroids: 8
Number of asteroids: 10
Number of asteroids: 12
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 11
Number of asteroids: 10
Number of asteroids: 12
Number of asteroids: 14
Number of asteroids: 16
Number of asteroids: 15
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 11
Number of asteroids: 10
Number of asteroids: 12
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 11
Number of asteroids: 10
Number of asteroids: 12
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 15
Number of asteroids: 14
Number of asteroids: 16
Number of asteroids: 18
Number of asteroids: 17
Number of asteroids: 16
Number of asteroids: 15
Number of asteroids: 14
Number of asteroids: 13
Number of asteroids: 12
Number of asteroids: 11
Number of asteroids: 10
Number of asteroids: 9
Average speed: 99.74% (71 seconds)
```

## Author

Rick Umali - rickumali@gmail.com
