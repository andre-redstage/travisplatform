#!/bin/bash

# print outputs and exit on first failure
set -xe

if [ $TRAVIS_BRANCH == "master" ] ; then    
    
    openssl aes-256-cbc -K $encrypted_790cf80679f9_key -iv $encrypted_790cf80679f9_iv -in .travis/development.enc -out .travis/development -d
    
    chmod 600 .travis/development
    mv .travis/development ~/.ssh/id_rsa

    touch ~/.ssh/config
    
    echo -e "Host 142.54.227.126\n\tStrictHostKeyChecking no" >> /home/travis/.ssh/config
    echo -e "Host 52.200.159.125\n\tStrictHostKeyChecking no" >> /home/travis/.ssh/config

    # eval "$(ssh-agent -s)"
    # ssh-add ~/.ssh/deploy-key        
    # chmod 600 ~/.ssh/deploy-key 

    git config user.name "Travis CI"
    git config user.email "travis@test.com"

    # Used for server, such as ZeroLag.
    git remote add deploy "ssh://uat.travisplatform@dev03.redstage.cl.zerolag.com//www/sites/uat.travisplatform/files/git"    
    git push -f deploy master
    # --

    # Used for Platform.sh
    git remote add platform "hjec3fcqxqntw@git.us.magento.cloud:hjec3fcqxqntw.git"
    git push -f platform master
    # --
else

    echo "No deploy script for branch '$TRAVIS_BRANCH'"

fi