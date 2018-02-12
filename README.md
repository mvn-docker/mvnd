# mvnd

Maven meets docker

This is a maven wrapper that runs maven inside an isolated docker container.

This guarantees a clean and reproduceable environment for Maven builds.

## What are the advantages? 

* Reproduceability: accross company is guarantee to be using the exact same environment
* Isolation: running inside a container means a fresh envinroment. No conflicting ports. No disk concurrency
* Multiple versions: project A may be using maven 3 and java 7, mean while, project B may be using maven 3.5 and java 8. No need to install, maintain or switch between java / maven versions.

## Instalation

Just download the script to your project:

```shell
$ wget https://raw.githubusercontent.com/mvn-docker/mvnd/master/mvnd
--2018-02-11 10:02:34--  https://raw.githubusercontent.com/mvn-docker/mvnd/master/mvnd
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.164.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.164.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 508 [text/plain]
Saving to: ‘mvnd’

mvnd                                         100%[==============================================================================================>]     508  --.-KB/s    in 0s      

2018-02-11 10:02:34 (32.3 MB/s) - ‘mvnd’ saved [1075]


$ chmod +x mvnd 

$ ./mvnd clean install
[INFO] Scanning for projects...
[INFO] 
[INFO] ------------------------------------------------------------------------
[INFO] Building 
```

## Benchmark

To checking the impact of running maven inside docker.
The following project was used as guinea pig https://github.com/velo/maven-formatter-plugin.

The first local build was discarted and was used only to warm up maven local cache.

Two threads were used as a way to put more preasure on CPU and see how much the build time degraded within docker.

### Ubuntu 17.10

Tradicional local `mvn clean install -T2`:
```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] formatter-plugin ................................... SUCCESS [  1.741 s]
[INFO] formatters ......................................... SUCCESS [  0.030 s]
[INFO] formatter-api ...................................... SUCCESS [  1.177 s]
[INFO] java-formatter ..................................... SUCCESS [ 19.410 s]
[INFO] java-formatter-test ................................ SUCCESS [  1.201 s]
[INFO] javascript-formatter ............................... SUCCESS [ 17.858 s]
[INFO] javascript-formatter-test .......................... SUCCESS [  1.559 s]
[INFO] formatter-maven-plugin ............................. SUCCESS [  3.433 s]
[INFO] formatter-maven-plugin-its ......................... SUCCESS [  7.081 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 48.084 s (Wall Clock)
[INFO] Finished at: 2018-02-12T22:26:49+13:00
[INFO] Final Memory: 195M/6211M
[INFO] ------------------------------------------------------------------------
```

Using `./mvnd clean install -T2` with image `mvnd/alpine_3_6-openjdk:8b-3.5.2`:
```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] formatter-plugin ................................... SUCCESS [  2.016 s]
[INFO] formatters ......................................... SUCCESS [  0.038 s]
[INFO] formatter-api ...................................... SUCCESS [  1.597 s]
[INFO] java-formatter ..................................... SUCCESS [ 18.499 s]
[INFO] java-formatter-test ................................ SUCCESS [  1.323 s]
[INFO] javascript-formatter ............................... SUCCESS [ 17.118 s]
[INFO] javascript-formatter-test .......................... SUCCESS [  1.878 s]
[INFO] formatter-maven-plugin ............................. SUCCESS [  3.685 s]
[INFO] formatter-maven-plugin-its ......................... SUCCESS [  8.649 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 51.273 s (Wall Clock)
[INFO] Finished at: 2018-02-12T09:34:00Z
[INFO] Final Memory: 191M/4969M
[INFO] ------------------------------------------------------------------------
```

Using `./mvnd clean install -T2` with image `maven`:
```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] formatter-plugin ................................... SUCCESS [  1.723 s]
[INFO] formatters ......................................... SUCCESS [  0.038 s]
[INFO] formatter-api ...................................... SUCCESS [  1.218 s]
[INFO] java-formatter ..................................... SUCCESS [ 18.542 s]
[INFO] java-formatter-test ................................ SUCCESS [  1.114 s]
[INFO] javascript-formatter ............................... SUCCESS [ 17.332 s]
[INFO] javascript-formatter-test .......................... SUCCESS [  1.554 s]
[INFO] formatter-maven-plugin ............................. SUCCESS [  3.416 s]
[INFO] formatter-maven-plugin-its ......................... SUCCESS [  7.685 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 47.719 s (Wall Clock)
[INFO] Finished at: 2018-02-12T09:30:58Z
[INFO] Final Memory: 189M/4844M
[INFO] ------------------------------------------------------------------------
```

### macOS

Tradicional local `mvn clean install -T2`:
```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] formatter-plugin ................................... SUCCESS [  2.981 s]
[INFO] formatters ......................................... SUCCESS [  0.040 s]
[INFO] formatter-api ...................................... SUCCESS [  1.694 s]
[INFO] java-formatter ..................................... SUCCESS [ 21.804 s]
[INFO] java-formatter-test ................................ SUCCESS [  2.813 s]
[INFO] javascript-formatter ............................... SUCCESS [ 20.746 s]
[INFO] javascript-formatter-test .......................... SUCCESS [  3.411 s]
[INFO] formatter-maven-plugin ............................. SUCCESS [  7.228 s]
[INFO] formatter-maven-plugin-its ......................... SUCCESS [ 10.549 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 01:04 min (Wall Clock)
[INFO] Finished at: 2018-02-12T22:57:18+13:00
[INFO] Final Memory: 160M/1560M
[INFO] ------------------------------------------------------------------------
```

Using `./mvnd clean install -T2` with image `mvnd/alpine_3_6-openjdk:8b-3.5.2`:
```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] formatter-plugin ................................... SUCCESS [ 13.160 s]
[INFO] formatters ......................................... SUCCESS [  0.087 s]
[INFO] formatter-api ...................................... SUCCESS [  3.885 s]
[INFO] java-formatter ..................................... SUCCESS [ 41.653 s]
[INFO] java-formatter-test ................................ SUCCESS [  7.554 s]
[INFO] javascript-formatter ............................... SUCCESS [ 40.568 s]
[INFO] javascript-formatter-test .......................... SUCCESS [  8.645 s]
[INFO] formatter-maven-plugin ............................. SUCCESS [ 14.782 s]
[INFO] formatter-maven-plugin-its ......................... SUCCESS [ 17.564 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 02:09 min (Wall Clock)
[INFO] Finished at: 2018-02-12T10:00:24Z
[INFO] Final Memory: 102M/322M
[INFO] ------------------------------------------------------------------------
```
