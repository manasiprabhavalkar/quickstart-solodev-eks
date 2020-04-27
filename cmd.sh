#!/bin/bash

args=("$@")

init(){
    git submodule init
    git remote add upstream https://github.com/aws-quickstart/quickstart-amazon-eks.git
    git submodule add https://github.com/aws-quickstart/quickstart-amazon-eks-cluster-resource-provider.git ./functions/source/EksClusterResource
}

pullMaster() {
    git pull https://github.com/aws-quickstart/quickstart-amazon-eks.git master --allow-unrelated-histories
    git fetch upstream
    git checkout master
    git merge upstream/master
}

update(){
    git submodule update
}

build(){
    taskcat test run
}

tag(){
    VERSION="${args[1]}"
    git tag -a v${VERSION} -m "tag release"
    git push --tags
}


$*