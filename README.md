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
rick@Mac:~/Projects/mame0258-x86 $ time ./mame asteroid -window -nomax
ASTEROIDS: Stats Plugin On
Number of ships: 3
Wave: 1 Asteroids: 4
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 8
Wave: 1 Asteroids: 7
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 4
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 8
Wave: 1 Asteroids: 7
Number of ships: 2
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 7
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 8
Wave: 1 Asteroids: 7
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 7
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 8
Wave: 1 Asteroids: 7
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 4
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 4
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 4
Wave: 1 Asteroids: 6
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 4
Wave: 1 Asteroids: 3
Wave: 1 Asteroids: 5
Wave: 1 Asteroids: 4
Wave: 1 Asteroids: 3
Wave: 1 Asteroids: 2
Wave: 1 Asteroids: 1
Wave: 1 Asteroids: DONE
Wave: 2 Asteroids: 6
Wave: 2 Asteroids: 8
Wave: 2 Asteroids: 10
Wave: 2 Asteroids: 12
Wave: 2 Asteroids: 14
Wave: 2 Asteroids: 13
Wave: 2 Asteroids: 12
Wave: 2 Asteroids: 11
Wave: 2 Asteroids: 10
Wave: 2 Asteroids: 12
Wave: 2 Asteroids: 14
Wave: 2 Asteroids: 16
Wave: 2 Asteroids: 15
Wave: 2 Asteroids: 14
Wave: 2 Asteroids: 16
Wave: 2 Asteroids: 15
Wave: 2 Asteroids: 14
Wave: 2 Asteroids: 13
Wave: 2 Asteroids: 12
Wave: 2 Asteroids: 11
Wave: 2 Asteroids: 10
Wave: 2 Asteroids: 9
Wave: 2 Asteroids: 8
Wave: 2 Asteroids: 10
Wave: 2 Asteroids: 9
Wave: 2 Asteroids: 11
Wave: 2 Asteroids: 13
Wave: 2 Asteroids: 15
Wave: 2 Asteroids: 14
Wave: 2 Asteroids: 15
Wave: 2 Asteroids: 14
Wave: 2 Asteroids: 13
Wave: 2 Asteroids: 12
Wave: 2 Asteroids: 11
Number of ships: 1
Wave: 2 Asteroids: 10
Wave: 2 Asteroids: 9
Wave: 2 Asteroids: 8
Wave: 2 Asteroids: 7
Wave: 2 Asteroids: 6
Wave: 2 Asteroids: 8
Wave: 2 Asteroids: 7
Wave: 2 Asteroids: 6
Wave: 2 Asteroids: 8
Wave: 2 Asteroids: 7
Wave: 2 Asteroids: 6
Wave: 2 Asteroids: 8
Wave: 2 Asteroids: 10
Wave: 2 Asteroids: 9
Wave: 2 Asteroids: 8
Wave: 2 Asteroids: 7
Wave: 2 Asteroids: 6
Wave: 2 Asteroids: 5
Wave: 2 Asteroids: 4
Wave: 2 Asteroids: 3
Wave: 2 Asteroids: 2
Wave: 2 Asteroids: 4
Wave: 2 Asteroids: 3
Wave: 2 Asteroids: 2
Wave: 2 Asteroids: 1
Wave: 2 Asteroids: DONE
Wave: 3 Asteroids: 8
Average speed: 99.61% (101 seconds)

real    1m47.230s
user    0m25.477s
sys     0m7.106s
```

## Author

Rick Umali - rickumali@gmail.com
