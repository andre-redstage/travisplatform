#!/bin/bash

#Only update the production/development server after PR has been accepted
if [ $TRAVIS_PULL_REQUEST == "false" ]
then

	openssl aes-256-cbc -k "$SECRET_FILE_PASS" -in .travis/development.enc -out .travis/development -d

	set -xe

	chmod 600 .travis/development
	mv .travis/development ~/.ssh/id_rsa

	git config user.name "Travis CI"
	git config user.email "travis@test.com"

	if [ $TRAVIS_BRANCH == "master" ]
	then
	    
	    git remote add production $PRODUCTION_REMOTE
	    git push -f production $TRAVIS_BRANCH    

	fi

	git remote add development $DEVELOPMENT_REMOTE
	git push -f development $TRAVIS_BRANCH
fi