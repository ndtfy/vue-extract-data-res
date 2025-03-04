#!/usr/bin/env sh

# остановить публикацию при ошибках
set -e

# сборка
npm run build

# переход в каталог сборки
cd dist

# если вы публикуете на пользовательский домен
# echo 'ndt.to' > CNAME

git init
git add -A
git commit -m 'deploy'

# если вы публикуете по адресу https://ndtfy.github.io
# git push -f git@github.com:ndtfy/ndtfy.github.io.git master

# если вы публикуете по адресу https://ndtfy.github.io/vue-extract-data
git push -f git@github.com:ndtfy/vue-extract-data.git master:gh-pages

cd -
