# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* DB
# miyakolo DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|default: "",null: false|
|encrypted_password|string|default: "",null: false|
|username|string||
|name|string||
|website|string||
|phone|integer||
|gender|string||
### Association
- devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
- has_one_attached :avatar
- has_many :posts, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :liked_posts, through: :likes, source: :post
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user
- belongs_to :home

## postsテーブル
|Column|Type|Options|
|------|----|-------|
|description|string||
|user_id|integer||
### Association
- belongs_to :user
- has_one_attached :image
- has_many :likes
- has_many :liked_users, through: :likes, source: :user
- has_many :post_hash_tags
- has_many :hash_tags, through: :post_hash_tags
- validate :image_presence
- after_commit :create_hash_tags, on: :create
- has_many :map

## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|bigint|foreign_key: true,column: "follow_id"|
|follow_id|bigint||
### Association
- belongs_to :user
- belongs_to :follow,class_name: 'User'
- validates :user_id,presence: true
- validates :follow_id, presence: true

## post_hash_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|post_id|bigint||
|hash_tag_id|bigint||
### Association
- belongs_to :post
- belongs_to :hash_tag

## mapsテーブル
|Column|Type|Options|
|------|----|-------|
|hash_tag_id|bigint||
|post_id|bigint||
|region|string||
### Association
- belongs_to :post
- belongs_to :hash_tag

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|post_id|bigint|foreign_key: true|
|user_id|bigint|foreign_key: true|
### Association
- belongs_to :post
- belongs_to :user
- validates_uniqueness_of :post_id, scope: :user_id

## homesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|bigint|foreign_key: true|
### Association
- has_many :users

## hash_tags テーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many :post_hash_tags
- has_many :posts, through: :post_hash_tags

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|user_id|integer|null: false, foreign_key: true|
- belongs_to :user
