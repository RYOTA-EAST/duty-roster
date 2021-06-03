# アプリ名
duty roster(当番表)

[https://duty-roster-ryo-east.herokuapp.com/]

# 概要
当番をした回数、順番を管理するアプリ

# 制作背景(意図)
## 日常の体験
- 朝礼や清掃、仕事・地域・プライベートで当番はどこかに存在している
- 紙で当番を回覧の様に回していると持っている本人しか当番がわからず、忘れた際に誰かわからない
- 不公平さをなくすため回数の管理をするのも紙を増やすなど記入が大変

## 経験から考えたこと
- 当番を電子化して誰でも記録・チェックできれば本人が抜けても他の人で確認できる
- 電子化した際に回数をカウントし見える化することで不公平さの解消

# データベース設計

## userテーブル

| Column              | Type      | Options                |
| ------------------- | --------- | ---------------------- |
| nickname            | string    | null:false,unique:true |
| email               | string    | null:false,unique:true |
| encrypted_password  | string    | null:false             |

### Association
- has_many :duty_users
- has_many :duties, through: :duty_users
- belongs_to :roster

## dutyテーブル

| Column              | Type      | Options       |
| ------------------- | --------- | ------------- |
| name                | string    | null:false    |

### Association
- has_many :duty_users
- has_many :users, through: :duty_users
- has_many :roster

## duty-userテーブル

| Column     | Type         | Options           |
| ---------- | ------------ | ----------------- |
| duty       | reference    | foreign_key:true  |
| user       | reference    | foreign_key:true  |

### Association
- belongs_to :duty
- belongs_to :user

## rosterテーブル

| Column    | Type         | Options                      |
| --------- | ------------ | ---------------------------- |
| date      | date         | null:false                   |
| duty      | reference    | null:false,foreign_key:true  |
| user      | reference    | null:false,foreign_key:true  |

### Association
- belongs_to :duty
- belongs_to :user

## バックエンド
Ruby、Ruby on Rails
## フロントエンド
Haml、bootstap、Javascript
## データベース
MySQL
## 本番環境
Heroku
## ソース管理
Git、Github
## テスト
Rspec
## エディダ
VScode

# 課題や今後実装したい機能
- 実行する内容をメモで残し表示する
- マークを登録時に決めることができる（現状：○ → 改修後：◎）※複数できる様にするかは利便性と合わせて要検討