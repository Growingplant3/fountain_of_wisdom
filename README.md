##### Tasksテーブル
---
| Column | Data type |
| ---- | ---- |
| name | string |
| detail | text |
| priority | integer |
| situation | integer |
| deadline | datetime |

##### Herokuへのデプロイ手順
---
1. メールアドレスとパスワードでHerokuの認証を行う
```
$ heroku login
```
2. アプリケーションを作成する(2回目以降のアプリ更新時は不要)
```
$ heroku create
```
3. gitとの連携を確認する(連携していれば5へ、連携していなければ4へ)
```
$ git remote -v
```
4. gitと連携する
```
$ git remote リポジトリ名 URL
```
> リポジトリ名：Heroku(を使うのが一般的)<br>
> URL：アプリ名.gitで記述された絶対パス<br>

5. 作業ツリーに差分がないか確認する(差分があれば6へ、差分がなければ7へ)
```
$ git status
```
6. 差分をコミットする
```
$ git add .
$ git commit -m "コミット名"
```
7. Heroku上でコンパイルの用意をする(2回目以降は不要です)
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
8. Herokuにデプロイする
```
$ git push リポジトリ名 master
```
> リポジトリ名は`$ git remote`で設定したものと同じです<br>
> masterは自分の環境で使っているブランチ名に適宜置き換えてください<br>
9. マイグレーションの実行
```
$ heroku run rails db:migrate
```
> `$ heroku run rails db:create`は既に自動で実行されたので不要です
10. アプリ名の確認(画面上にアプリ名が出力されます)
```
$ heroku config
```
11. アプリの確認
```
https://アプリ名.herokuapp.com/
```
ブラウザ上にルートパス(config/routes.rbで記述したもの)が正しく表示されていれば、お使いのHerokuは正常にデプロイされました
