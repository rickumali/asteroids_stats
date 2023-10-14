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
rick@Mac:~/Projects/mame0258-x86 $ ./mame asteroid -window -nomax
ASTEROIDS: Stats Plugin On
Number of ships: 3
Wave: 1 Number of asteroids: 4
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 8
Wave: 1 Number of asteroids: 10
Wave: 1 Number of asteroids: 9
Wave: 1 Number of asteroids: 8
Wave: 1 Number of asteroids: 7
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 5
Wave: 1 Number of asteroids: 4
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 8
Wave: 1 Number of asteroids: 10
Wave: 1 Number of asteroids: 9
Wave: 1 Number of asteroids: 8
Wave: 1 Number of asteroids: 7
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 5
Wave: 1 Number of asteroids: 4
Wave: 1 Number of asteroids: 3
Wave: 1 Number of asteroids: 5
Wave: 1 Number of asteroids: 7
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 8
Wave: 1 Number of asteroids: 7
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 8
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 8
Wave: 1 Number of asteroids: 7
Wave: 1 Number of asteroids: 6
Wave: 1 Number of asteroids: 5
Wave: 1 Number of asteroids: 4
Wave: 1 Number of asteroids: 3
Wave: 1 Number of asteroids: 2
Wave: 1 Number of asteroids: 1
Wave: 1 Number of asteroids: 3
Wave: 1 Number of asteroids: 2
Wave: 1 Number of asteroids: 1
Wave: 1 Number of asteroids: 0
Wave: 2 Number of asteroids: 6
Wave: 2 Number of asteroids: 8
Wave: 2 Number of asteroids: 10
Wave: 2 Number of asteroids: 12
Wave: 2 Number of asteroids: 11
Wave: 2 Number of asteroids: 10
Wave: 2 Number of asteroids: 9
Wave: 2 Number of asteroids: 11
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 12
Wave: 2 Number of asteroids: 11
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 15
Wave: 2 Number of asteroids: 14
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 15
Wave: 2 Number of asteroids: 17
Wave: 2 Number of asteroids: 16
Wave: 2 Number of asteroids: 15
Wave: 2 Number of asteroids: 14
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 15
Wave: 2 Number of asteroids: 17
Wave: 2 Number of asteroids: 16
Wave: 2 Number of asteroids: 15
Wave: 2 Number of asteroids: 14
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 15
Wave: 2 Number of asteroids: 14
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 15
Wave: 2 Number of asteroids: 14
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 12
Wave: 2 Number of asteroids: 11
Wave: 2 Number of asteroids: 13
Wave: 2 Number of asteroids: 12
Wave: 2 Number of asteroids: 11
Wave: 2 Number of asteroids: 10
Wave: 2 Number of asteroids: 9
Wave: 2 Number of asteroids: 8
Wave: 2 Number of asteroids: 10
Wave: 2 Number of asteroids: 12
Wave: 2 Number of asteroids: 11
Wave: 2 Number of asteroids: 10
Wave: 2 Number of asteroids: 9
Wave: 2 Number of asteroids: 8
Wave: 2 Number of asteroids: 7
Wave: 2 Number of asteroids: 6
Wave: 2 Number of asteroids: 5
Wave: 2 Number of asteroids: 7
Wave: 2 Number of asteroids: 6
Wave: 2 Number of asteroids: 5
Wave: 2 Number of asteroids: 4
Wave: 2 Number of asteroids: 3
Wave: 2 Number of asteroids: 5
Wave: 2 Number of asteroids: 4
Wave: 2 Number of asteroids: 3
Wave: 2 Number of asteroids: 2
Wave: 2 Number of asteroids: 1
Wave: 2 Number of asteroids: 0
Wave: 3 Number of asteroids: 8
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 9
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 13
Wave: 3 Number of asteroids: 15
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 16
Wave: 3 Number of asteroids: 15
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 16
Wave: 3 Number of asteroids: 15
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 13
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 16
Wave: 3 Number of asteroids: 18
Wave: 3 Number of asteroids: 20
Wave: 3 Number of asteroids: 19
Wave: 3 Number of asteroids: 18
Wave: 3 Number of asteroids: 17
Wave: 3 Number of asteroids: 16
Wave: 3 Number of asteroids: 15
Wave: 3 Number of asteroids: 17
Wave: 3 Number of asteroids: 16
Wave: 3 Number of asteroids: 15
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 13
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 13
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 16
Wave: 3 Number of asteroids: 15
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 13
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 16
Wave: 3 Number of asteroids: 15
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 13
Wave: 3 Number of asteroids: 14
Wave: 3 Number of asteroids: 13
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 9
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 12
Wave: 3 Number of asteroids: 11
Wave: 3 Number of asteroids: 10
Wave: 3 Number of asteroids: 9
Wave: 3 Number of asteroids: 8
Wave: 3 Number of asteroids: 7
Number of ships: 2
Wave: 3 Number of asteroids: 6
Wave: 3 Number of asteroids: 5
Wave: 3 Number of asteroids: 4
Wave: 3 Number of asteroids: 6
Wave: 3 Number of asteroids: 5
Wave: 3 Number of asteroids: 4
Wave: 3 Number of asteroids: 3
Wave: 3 Number of asteroids: 2
Wave: 3 Number of asteroids: 1
Number of ships: 3
Wave: 3 Number of asteroids: 0
Wave: 4 Number of asteroids: 10
Wave: 4 Number of asteroids: 12
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 16
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 16
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 13
Wave: 4 Number of asteroids: 12
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 16
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 13
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 18
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 16
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 19
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 20
Wave: 4 Number of asteroids: 22
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 23
Wave: 4 Number of asteroids: 22
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 20
Wave: 4 Number of asteroids: 22
Wave: 4 Number of asteroids: 24
Wave: 4 Number of asteroids: 23
Wave: 4 Number of asteroids: 25
Wave: 4 Number of asteroids: 27
Wave: 4 Number of asteroids: 26
Wave: 4 Number of asteroids: 25
Wave: 4 Number of asteroids: 24
Wave: 4 Number of asteroids: 26
Wave: 4 Number of asteroids: 25
Wave: 4 Number of asteroids: 24
Wave: 4 Number of asteroids: 23
Wave: 4 Number of asteroids: 22
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 20
Wave: 4 Number of asteroids: 22
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 20
Wave: 4 Number of asteroids: 19
Wave: 4 Number of asteroids: 18
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 19
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 22
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 20
Wave: 4 Number of asteroids: 22
Wave: 4 Number of asteroids: 21
Wave: 4 Number of asteroids: 19
Wave: 4 Number of asteroids: 18
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 19
Wave: 4 Number of asteroids: 18
Number of ships: 2
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 16
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 16
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 13
Wave: 4 Number of asteroids: 12
Wave: 4 Number of asteroids: 14
Number of ships: 1
Wave: 4 Number of asteroids: 13
Wave: 4 Number of asteroids: 12
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 13
Wave: 4 Number of asteroids: 15
Wave: 4 Number of asteroids: 17
Wave: 4 Number of asteroids: 16
Wave: 4 Number of asteroids: 15
Number of ships: 0
Wave: 4 Number of asteroids: 14
Wave: 4 Number of asteroids: 13
Average speed: 100.00% (191 seconds)
```

## Author

Rick Umali - rickumali@gmail.com
