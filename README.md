# nix-container-build-gha

This is a simple testing repo I used to understand how to build python environments in github actions
with nix. I wrote up my thoughts on this medium post.

This is the public version of the repo which anyone can look through; I also maintain a private version 
which is linked to some self hosted github runners - I don't want to link the public version to any such
runners.

There are comments in the code which give some pointers on how things work - feel free to look around.

## The python application

The python application was taken from [this repo](https://github.com/mitchellh/flask-nix-example) created by Mitchell Hashimoto - it is a simple flask application. 

I have included a couple of unecessary dependencies in the `pyproject.toml` just to understand how these are
handled (`torch`, `jupyter` and `beautifulsoup4`). They are available in the resulting python environment but not used by the application.

## Working locally

This assumes you have a sensible nix configuration and are comfortable using flakes.

- `nix build` will build the application and put the content in the `result` directory
- `nix build .#ociApplicationImage` will build a container image which runs the application - the resulting container image is a gzip'd tarball in the `result` directory which can be imported to docker using `docker load < result`
- `nix build .#ociPackageImage` will build a container image which contains the python environment but launches bash; run python within bash and you can import the dependencies
- `nix run` will run the application without building a container image

## Using the github actions

The github action was essentially copied from [this repo](https://github.com/wagdav/thewagner.net).

It requires a token called DOCKER_ACCESS_TOKEN to access a docker repository and push the resulting container image there. This repo uses the standard github runners but in the private variant, I was using a self-hosted runner (there are a couple of comments in the github action definition which highlight the small differences).
