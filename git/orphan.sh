# This is a fork of the gist git_create_orphan.sh from user seanbuscay

cd repository
git checkout --orphan orphan_name
git rm -rf .
rm '.gitignore'
echo "#Title of Readme" > README.md
git add README.md
git commit -a -m "Initial Commit"
git push origin orphan_name
