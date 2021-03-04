# PAGE

docker container which wraps password-store abook gnupg git make terraform
packer

`key.pub` unlocks instance

build an image with packer for run instance

you need to have `./key.pub` in `pwd`
`docker run page build`

plan
```
%:
  terrform $@
```
