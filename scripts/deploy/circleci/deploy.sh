#!/usr/bin/env bash
# This script deploys the built site to the gh-pages branch of the same repo.
git config --global user.email $GH_EMAIL
git config --global user.name $GH_NAME

git clone git@github.com:$GH_ORG/$CIRCLE_PROJECT_REPONAME.git out

cd out
git checkout gh-pages || git checkout --orphan gh-pages
git rm -rfq .
cd ..

# The fully built site is already available at ~/repo/_site.
cp -a ~/repo/_site/. out/.

mkdir -p out/.circleci && cp -a .circleci/. out/.circleci/.
cd out

git add -A
git commit -m "Automated deployment to GitHub Pages: ${CIRCLE_SHA1}" --allow-empty

git push origin gh-pages
