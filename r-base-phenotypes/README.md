# Docker container for phenotypic data pre-processing in R


## Pull Docker image
```{bash}
docker pull casperdevisser/r-base-phenotypes:v0.6 #latest
```

## Build Docker image 

```{bash}
# Dockerfile VERSION = v0.6
docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t casperdevisser/r-base-phenotypes:$VERSION . 
```