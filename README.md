# Trajectory Of Life

転職活動をサポートするするためのアプリケーション

# 概要

転職活動において、自分が応募した企業を一括で確認することができる

また、自社開発・受託開発・SESにどんな割合で応募したのかを円グラフで確認することができる

# App URL

[https://trajectory-of-life.herokuapp.com/](https://trajectory-of-life.herokuapp.com/)

# 利用方法

1. 会員情報登録ページから新規登録・ログイン
2. 一覧ページへ遷移する
3. 新規投稿は右上の投稿ボタンをクリック
[![Image from Gyazo](https://i.gyazo.com/36946cc3a941a925b72c607f34f1e952.gif)](https://gyazo.com/36946cc3a941a925b72c607f34f1e952)
4. 投稿完了後は一覧ページへ戻る
[![Image from Gyazo](https://i.gyazo.com/874a03f88158a1fd406ba2b6bad606b5.gif)](https://gyazo.com/874a03f88158a1fd406ba2b6bad606b5)
5. 一覧ページから一つの投稿を選択 → 投稿詳細ページへ遷移する
[![Image from Gyazo](https://i.gyazo.com/f7ef9f079f52eb880cb0b54b39462f76.gif)](https://gyazo.com/f7ef9f079f52eb880cb0b54b39462f76)
6. 投稿詳細ページからは投稿の編集・削除が可能である
[![Image from Gyazo](https://i.gyazo.com/11976cee20f0c70d1ba28d862137da17.gif)](https://gyazo.com/11976cee20f0c70d1ba28d862137da17)
[![Image from Gyazo](https://i.gyazo.com/88098ca847c0801fe635051d5e0808f3.gif)](https://gyazo.com/88098ca847c0801fe635051d5e0808f3)
7. 投稿詳細ページからコメントができる
[![Image from Gyazo](https://i.gyazo.com/5ef5f57695b3887d768d1ab2eed467d3.gif)](https://gyazo.com/5ef5f57695b3887d768d1ab2eed467d3)
8. 一覧ページから右上のユーザー名をクリックすることでマイページに遷移できる
9. マイページではユーザー情報と投稿のカテゴリー別集計を円グラフで確認することができる
[![Image from Gyazo](https://i.gyazo.com/737dae8f5dfb48a920ae93c0d67a6468.gif)](https://gyazo.com/737dae8f5dfb48a920ae93c0d67a6468)

# 課題解決

| ユーザーストーリーから考える課題解決 | 課題解決 |
| :-- | :-- |
| 様々な転職サイトから応募しており一括で会社情報を管理することができない | アプリケーションで会社情報を投稿することで一覧で一括して確認できるようにする |
| どのカテゴリーの企業にどれだけ応募したか瞬時に確認することができない | カラムの情報から円グラフを作成することで視覚的に確認できるようにする |
| なぜその企業を応募したのか理由を記録しておきたい | 投稿の際に理由を記入することで詳細ページで応募理由をいつでも確認することができる |

# 機能一覧

| 機能 | 概要 |
| :-- | :-- |
| ユーザー管理機能 | 新規登録・ログイン・ログアウトが可能 |
| 投稿機能 | 会社情報の投稿が可能 |
| 投稿詳細表示機能 | 各投稿詳細が詳細ページで閲覧が可能 |
| 投稿編集・削除機能 | 投稿者本人のみ投稿編集・削除が可能 |
| ユーザー詳細表示機能 | 各ユーザーのプロフィール・カテゴリー別集計の閲覧が可能 |
| コメント機能 | 投稿詳細ページからコメントが可能 |

# ローカルでの動作方法

- $ git clone https://github.com/kohohsuke/trajectory_of_life.git
- $ cd trajectory_of_life
- $ bundle install
- $ rails db:create
- $ rails db:migrate
- $ rails s
- http://localhost:3000/

# 開発環境

- VScode
- Ruby 2.6.5
- Rails 6.0.0
- MySQL2 0.4.4

# DB設計

## usersテーブル

| Column             | Type   | Options                       |
| -------------------| ------ | ----------------------------- |
| nickname           | string | null: false, uniqueness: true |
| email              | string | null: false                   |
| encrypted_password | string | null: false                   |

### Association

- has_many :companies
- has_many :comments

## companiesテーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| post_code      | string     | null: false                    |
| address        | string     | null: false                    |
| website        | string     | null: false                    |
| category_id    | integer    | null: false                    |
| occupation_id  | integer    | null: false                    |
| characteristic | text       | null: false                    |
| first_reason   | string     | null: false                    |
| second_reason  | string     | null: false                    |
| third_reason   | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## commentsテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| text       | text       | null: false                    |
| user_id    | references | null: false, foreign_key: true |
| company_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :company