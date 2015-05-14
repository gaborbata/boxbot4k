BoxBot4k
========

Overview
--------
BoxBot4k (which is a clone of the famous [Sokoban](http://en.wikipedia.org/wiki/Sokoban) game) is an entry for the [2010 Java 4K](http://www.java4k.com/index.php?action=games&method=view&gid=281) Game Programming Contest. The goal of the contest is to develop the best game possible within four kilobytes (4096 bytes) of data.

![BoxBot4k](https://raw.githubusercontent.com/gaborbata/boxbot4k/master/resources/boxbot4k-screenshot.png)

Game rules
----------
The goal of the game to push boxes around a maze and try to put them in designated locations (squares with red pattern) by controlling a robot. Only one box may be pushed at a time, and boxes cannot be pulled.

The game contains 50 levels which are based on Francois Marques' Novoban levelset with some modifications.

Game controls
-------------
* Arrow keys: move the robot
* Backspace: restart level
* PgUp/PgDn: go to next/previous level

How to compile
--------------
Use `mvn clean package` or `gradle clean build` which do the following:

* compile sources with `javac -target 1.5 B.java`
* create jar files:
    * application: `jar cvfe boxbot4k-app.jar B *.class`
    * applet: `jar cvf boxbot4k-applet.jar *.class`
* optimize/obfuscate classes with [ProGuard](http://proguard.sourceforge.net/)
* repack jar files with [advzip](http://advancemame.sourceforge.net/comp-readme.html) using the [zopfli](https://github.com/google/zopfli) compression algorithm

Currently, the build configuration of the project does not support producing optimized output (i.e. jars with 4k size limit) for non-Windows environments which is due to the Windows version of advzip executable.
advzip is available on Linux and MacOSX as well (in source form) but I haven't got chance to try them and create separate build profiles for those operating systems.

Usage
-----
Java 5 or later is recommended to run the game.

* Application: Most platforms have a mechanism to execute `.jar` files (e.g. double click the `boxbot4k-app-1.0.1.jar`).
  You can also run the game from the command line by typing:

        java -jar boxbot4k-app-1.0.1.jar

* Applet: Open `boxbot4k-applet-1.0.1.html` in a web browser which supports Java applets.

HTML5 port
----------
An experimental HTML5/JavaScript port has also been created of the game (using the the `canvas` element).

It can be found in the `boxbot4k-html5` folder.

License
-------
Copyright (c) 2009-2010 Gabor Bata

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
