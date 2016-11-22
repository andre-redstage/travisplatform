#!/bin/bash

#Only update the production/development server after PR has been accepted
if [ $TRAVIS_PULL_REQUEST == "false" ]
then

	#openssl aes-256-cbc -K $encrypted_790cf80679f9_key -iv $encrypted_790cf80679f9_iv -in .travis/development.enc -out .travis/development -d

	openssl aes-256-cbc -k "$SECRET_FILE_PASS" -in .travis/development_test.enc -out .travis/development -d

	set -xe

	chmod 600 .travis/development
	mv .travis/development ~/.ssh/id_rsa

	git config user.name "Travis CI"
	git config user.email "travis@test.com"

	if [ $TRAVIS_BRANCH == "master" ]
	then
	    
	    git remote add deploy $PRODUCTION_REMOTE
	    git push -f deploy $TRAVIS_BRANCH    

	fi

	git remote add platform $PLATFORM_REMOTE
	git push -f platform $TRAVIS_BRANCH
fi