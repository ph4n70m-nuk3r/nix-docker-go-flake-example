# nix-docker-go-flake-example
![CI Status](https://github.com/ph4n70m-nuk3r/nix-docker-go-flake-example/actions/workflows/ci.yaml/badge.svg)
## Prerequisites
Either:
- create `export-gh-pat.sh` file with contents like:  
  `export GH_PAT='PASTE_YOUR_TOKEN_HERE'`
- or, comment out lines `12` and `13` in `build.sh`.
-------------------------------------------
## Build app
```shell
./build.sh app
ls -lah result/bin/
```
-------------------------------------------
## Run app
```shell
./result/bin/nix-docker-go-flake-example # Use Ctrl+C to quit.
```
-------------------------------------------
## Build image (default build target)
```shell
./build.sh  # OR ./build.sh docker
ls -lah result
```
-------------------------------------------
## Load image
```shell
docker load < result
docker image ls
```
-------------------------------------------
## Run image
```shell
docker run -d --name='ndgfe' --rm -p '8080:8080' nix-docker-go-flake-example:latest
```
-------------------------------------------
## Stop image
```shell
docker stop 'ndgfe'
```
-------------------------------------------
## Using the app
### cURL:
```shell
curl http://localhost:8080/metrics
```
### Browser:  
- http://localhost:8080/
- http://localhost:8080/info
- http://localhost:8080/metrics  
