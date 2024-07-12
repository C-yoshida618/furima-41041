# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_kana    | string | null: false |
| last_name_kana     | string | null: false |
| birthday           | date   | null: false |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column      | Type       | Options     |
| ------      | ------     | ----------- |
| item_name   | string     | null: false |
| price       | integer    | null: false |
| description | text       | null: false |
| user        | references | null: false, foreign_key: true |
| category_id | integer    | null: false |
| status_id   | integer    | null: false |
| shipping_cost_id | integer | null: false |
| shipping_day_id  | integer | null: false |
| shipping_area_id | integer | null: false |

### Association

- belongs_to:user
- has_one :order

## purchases table テーブル

| Column           | Type       | Options                        |
| ------           | ---------- | ------------------------------ |
| order            | references | null: false, foreign_key: true |
| postcode         | string     | null: false |
| shipping_area_id | integer    | null: false |
| city             | string     | null: false |
| address          | string     | null: false |
| building_name    | string     |
| phone_number     | string     | null: false |


### Association

- belongs_to :order

## orders table テーブル

| Column        | Type       | Options                        |
| ------        | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one : purchase
