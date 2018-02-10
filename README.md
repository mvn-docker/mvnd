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

