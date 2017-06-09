# Jump to git root
cd ../..

haxe dev/ci/build-interp.hxml
haxe dev/ci/build-neko.hxml         && neko bin/neko/TestMainHx.n
haxe dev/ci/build-js.hxml           && node bin/js/TestMainHx.js

# Skip phantom js test 
#                                    && haxe dev/phantomjs/run.hxml bin/js/TestMainHx.js

# Skip java
# haxe dev/ci/build-java.hxml         && java -jar bin/java/TestMainHx.jar

# Skip php
#haxe dev/ci/build-php.hxml          && php bin/php/index.php

# Skip php7 test
#haxe dev/ci/build-php7.hxml         && php bin/php7/index.php

# Skip c
#haxe dev/ci/build-cs.hxml           && mono bin/cs/bin/TestMainHx.exe

# Skip flash
#haxe dev/ci/build-flash.hxml -D fdb && haxe dev/flash/run.hxml bin/flash/TestMainHx.swf

# Skip cpp
#haxe dev/ci/build-cpp.hxml          && bin/cpp/TestMainHx

# Skip python
#haxe dev/ci/build-python.hxml       && python bin/python/TestMainHx.py