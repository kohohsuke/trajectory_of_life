# DB設計

## usersテーブル

| Column             | Type   | Options                   |
| -------------------| ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

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