# nix-docker-go-flake-example  

## Prerequisites
Either:
- create `export-gh-pat.sh` file with contents like:  
  `export GH_PAT='PASTE_YOUR_TOKEN_HERE'`
- or, comment out lines `12` and `13` in `build.sh`.
-------------------------------------------
## Build image
```shell
./build.sh
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
docker run -i -t --rm -p '8080:8080' nix-docker-go-flake-example:latest
```
-------------------------------------------
## Use the app  
Visit any of the following URLs in your browser:  
- http://localhost:8080/
- http://localhost:8080/info
- http://localhost:8080/metrics
