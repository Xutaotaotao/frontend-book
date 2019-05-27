git add .
git commit -m 'publish gh-pages'
git push origin master
git checkout gh-pages
rm -rf *
git checkout master -- _book
mv _book/* ./
rm -rf _book
git add .
git commit -m 'publish gh-pages'
git push origin gh-pages
