# DB情報

##User

|column|data|
|:---:|:---:|
|name|string|
|email|string|
|password_digest|string|

##Task

|column|data|
|:---:|:---:|
|title|text|
|content|text|
|user_id|bigint|

##favorite

|column|data|
|:---:|:---:|
|user_id|integer|
|task_id|integer|


<!-- 見出し	# 見出しh1 -->
# Herokuへのデプロイ手順
---

<!-- インライン表示	`テキスト` -->
<!-- 番号付きリスト	1. テキスト -->
１．送りたいディレクトリに移動
`vagrant@ubuntu-xenial:~/workspace$ cd manyo_kadai`

２．送りたいブランチに移動
`$ git checkout master`

３．リポジトリを初期化
`$ git init`

４．コミットする
    $ git add -A;
    $ git commit -m "   ";

５．Herokuアプリを作成
`$ heroku create`

６．デプロイ
`$ git push heroku master`

７．DB移行
`$ heroku run rails db:migrate`
