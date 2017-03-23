#!/bin/bash

function get_ngrok_cli () {
  # Get ngrok CLI
  #wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip -O temp.zip; unzip temp.zip; rm temp.zip
  wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip -qO- |bsdtar -xvf-
}

function build_jetpack_source () {
  # build Jetpack Admin Page
  # built files are left in ./jetpack/_inc/build
  cd jetpack &&
  # docker run --rm -it -v $(pwd):/jetpack -w /jetpack --name jetpack node:6 curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.17.8 && npm run build
    docker run --rm -it -v $(pwd):/jetpack -w /jetpack --name jetpack node:6 /bin/bash -c "rm /usr/local/bin/yarn && apt-get update && apt-get -y install php5-cli && curl -s -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.17.9 && PATH=/root/.yarn/bin:$PATH bash -c 'yarn distclean && yarn build'" &&
    # docker run -e YARN_VERSION='0.17.9'  --rm -it -v $(pwd):/jetpack -w /jetpack --name jetpack node:6 /bin/bash -c "npm run build" &&
    # docker run -e YARN_VERSION='0.18.2'  --rm -it -v $(pwd):/jetpack -w /jetpack --name jetpack node:6 /bin/bash -c "npm install yarn@0.18.2 && npm run build" &&
    cd ..
}

function is_jetpack_repo_dir() {
    [ -d jetpack/.git ] && true
}

fetch_jetpack_source() {
    # Get jetpack
    #git clone --depth 1 -b feature/settings-overhaul git@github.com:Automattic/jetpack.git
    git clone --depth 1 -b $1 git@github.com:Automattic/jetpack.git
}

get_jetpack () {

      fetch_jetpack_source $1
  # if is_jetpack_repo_dir; then 
  #   cd jetpack
  #   git checkout $1
  #   cd ..
  #   build_jetpack_source
  # else
  # fi
}

get_dockerfile () {
  wget -nc -q https://gist.githubusercontent.com/dmsnell/2548839a34180a4e2949815b42b7ed6c/raw/c27041a6aa14d7d8e8567fd4f409b1b777946faa/docker-compose.yml
  touch opcache-recommended.ini
}


prepare() {
    get_dockerfile
    
    get_jetpack feature/settings-overhaul
    build_jetpack_source
    get_ngrok_cli 
    
}

main() {
    prepare
}

main 