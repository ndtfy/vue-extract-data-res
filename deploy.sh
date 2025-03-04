#!/usr/bin/env sh

# ���������� ���������� ��� �������
set -e

# ������
npm run build

# ������� � ������� ������
cd dist

# ���� �� ���������� �� ���������������� �����
# echo 'ndt.to' > CNAME

git init
git add -A
git commit -m 'deploy'

# ���� �� ���������� �� ������ https://ndtfy.github.io
# git push -f git@github.com:ndtfy/ndtfy.github.io.git master

# ���� �� ���������� �� ������ https://ndtfy.github.io/vue-extract-data
git push -f git@github.com:ndtfy/vue-extract-data.git master:gh-pages

cd -
