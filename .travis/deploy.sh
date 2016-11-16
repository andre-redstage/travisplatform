#!/bin/bash

openssl aes-256-cbc -K $encrypted_790cf80679f9_key -iv $encrypted_790cf80679f9_iv -in .travis/development.enc -out .travis/development -d
    
chmod 600 .travis/development
mv .travis/development ~/.ssh/id_rsa

git config user.name "Travis CI"
git config user.email "travis@test.com"

if [$TRAVIS_BRANCH  == "master" ] ; then    

    #Using Zerolag as production
    git remote add deploy "ssh://uat.travisplatform@dev03.redstage.cl.zerolag.com//www/sites/uat.travisplatform/files/git"    
    git push -f deploy $TRAVIS_BRANCH    

fi

git remote add platform "hjec3fcqxqntw@git.us.magento.cloud:hjec3fcqxqntw.git"
git push -f platform $TRAVIS_BRANCH