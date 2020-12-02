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
3. アプリ名の確認(画面上にアプリ名が出力されます)
```
$ heroku config
```
4. gitとの連携を確認する(連携していれば6へ、連携していなければ5へ)
```
$ git remote -v
```
5. gitと連携する
```
$ git remote add リポジトリ名 URL
```
> リポジトリ名：heroku(を使うのが一般的)<br>
> URL： https://git.heroku.com/アプリ名.git で記述されたパス<br>
6. 作業ツリーに差分がないか確認する(差分があれば7へ、差分がなければ8へ)
```
$ git status
```
7. 差分をコミットする
```
$ git add .
$ git commit -m "コミット名"
```
8. Heroku上でコンパイルの用意をする(2回目以降は不要です)
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
9. Herokuにデプロイする
```
$ git push リポジトリ名 master
```
> リポジトリ名は`$ git remote add`で設定したものと同じです<br>
> masterは自分の環境で使っているブランチ名に適宜置き換えてください<br>
10. マイグレーションの実行
```
$ heroku run rails db:migrate
```
> `$ heroku run rails db:create`は既に自動で実行されたので不要です

11. アプリの確認
```
https://アプリ名.herokuapp.com/
```
ブラウザ上にルートパス(config/routes.rbで記述したもの)が正しく表示されていれば、Herokuのデプロイは正常に終了しました
