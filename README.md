BoxBot4k
========

Overview
--------
BoxBot4k (which is a clone of the famous Sokoban game) is an entry for the 2010 Java 4K Game Programming Contest. The goal of the contest is to develop the best game possible within four kilobytes (4096 bytes) of data.

![BoxBot4k](https://raw.githubusercontent.com/gaborbata/boxbot4k/master/resources/boxbot4k-screenshot.png)

Game rules
----------
The goal of the game to push boxes around a maze and try to put them in designated locations (squares with red pattern) by controlling a robot. Only one box may be pushed at a time, and boxes cannot be pulled.

The game contains 50 levels which are based on François Marques' Novoban levelset with some modifications.

Game controls
-------------
* Arrow keys: move the robot
* Backspace: restart level
* PgUp/PgDn: go to next/previous level

How to compile
--------------
Use `mvn clean install` or `gradle clean build` which do the following:

* compile sources with `javac -target 1.5 B.java`
* create jar files:
    * app: `jar cvfe boxbot4k-app.jar B *.class`
    * applet: `jar cvf boxbot4k-applet.jar *.class`
* optimize/obfuscate classes with [ProGuard](http://proguard.sourceforge.net/)
* repack jar files with [kzip](http://advsys.net/ken/utils.htm)

Currently, the build configuration of the project does not support producing optimized output (i.e. jars with 4k size limit) for non-Windows environments which is due to the Windows version of kzip executable.
kzip is available on Linux and MacOSX as well but I haven't got chance to try them and create separate build profiles for those operating systems.
