BoxBot4k
========

Overview
--------

BoxBot4k (which is a clone of the famous Sokoban game) is an entry for the 2010 [Java 4K Game Programming Contest](http://www.java4k.com/). The goal of the contest is to develop the best game possible within four kilobytes (4096 bytes) of data.

Rules
-----
The goal of the game to push boxes around a maze and try to put them in designated locations (squares with red pattern) by controlling a robot. Only one box may be pushed at a time, and boxes cannot be pulled.

The game contains 50 levels which are based on François Marques' Novoban levelset with some modifications.

Game controls
-------------
* Arrow keys: move the robot
* Backspace: restart level
* PgUp/PgDn: go to next/previous level

How to compile
--------------
Use `mvn clean install` which -- in brief -- does the following:

* compiles sources with `javac -target 1.5 B.java`
* creates jar files:
    * app: `jar cvfe boxbot4k-app.jar B *.class`
    * applet: `jar cvf boxbot4k-applet.jar *.class`
* optimizes/obfuscates classes with [ProGuard](http://proguard.sourceforge.net/)
* repacks jar files with [kzip](http://advsys.net/ken/utils.htm)
