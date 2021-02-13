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
- belongs_to :check

## dutyテーブル

| Column              | Type      | Options       |
| ------------------- | --------- | ------------- |
| name                | string    | null:false    |

### Association
- has_many :duty_users
- has_many :users, through: :duty_users

## duty-userテーブル

| Column     | Type         | Options           |
| ---------- | ------------ | ----------------- |
| duty       | reference    | foreign_key:true  |
| user       | reference    | foreign_key:true  |

### Association
- belongs_to :duty
- belongs_to :user

## checkテーブル

| Column              | Type      | Options       |
| ------------------- | --------- | ------------- |
| date                | date      | null:false    |

### Association
- has_many :duties, through: :duty_check

## duty-checkテーブル

| Column     | Type         | Options                      |
| ---------- | ------------ | ---------------------------- |
| duty       | reference    | null:false,foreign_key:true  |
| check      | reference    | null:false,foreign_key:true  |

### Association
- belongs_to :duty
- belongs_to :check