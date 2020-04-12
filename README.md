# MIYAKOLO(宮古島地域SNSアプリ)
宮古島に特化した地域型SNSです。  

![demo](https://i.gyazo.com/b4a3131b8c98a4cdfc0899b7ab7f9c4d.gif)  
SNS上を旅したくなるトップページ  

・ツイート投稿機能  
・ツイート画像のギャラリー機能  
・ツイートで反響の多いロケーションを地図上で確認する機能  
を実装している。

![demo](https://i.gyazo.com/497d173f5635417eb7a5cd4ab4e3cc26.png)  
・ツイートで反響の多いロケーションを地図上で確認する機能  

![demo](https://i.gyazo.com/6e22fb98df2ff5f640b2f92ce6d37608.png)  
・マイページ  
⇨いいね機能、フォロー機能、ランキング機能を実装している。

# 制作背景
### ガイドブックに乗っていない本当に魅力的な観光スポットをSNSから配信するため。
大規模なメディアにより、代表的な観光地には簡単にアクセスできるようになりました。  
しかし、その弊害で旅をする場所が短調になってしまったようにも思います。  

私は昔、沖縄に移住をしていました。その時に地元の方から勧められる場所には  
ガイドマップに載っていない場所も多くありました。  
そして、そのどれもが本当に素晴らしい場所でした。  

宮古島に訪れた人、宮古島に住んでいる人がSNS上でコミュニティを形成し、  
その中で得た情報を基に本当に魅力のあるスポットを観光をする。  
そんなプラットフォームを作るために、このアプリを制作しました。  

# 工夫したポイント
・GoogleMap APIを使って、地図情報とツイートの紐つけをしました。  
・ビューにCSSアニメーションとJavaScriptを使い、アプリの中で旅をしたくなるようなメインページを作成しました。  
・Chart.jsでいいね数やハッシュタグ利用数を可視化しました。

# 本番環境
https://miyakolo.herokuapp.com/  

テストアカウント：  
ID：test@gmail.com  
Password:testtest  
※現在、一部機能を調整中です。  

# 使用技術(開発環境)
使用言語：Ruby/ Ruby on Rails/ Haml/ Sass/ jQuery  
デプロイ環境：Heroku  

# 課題や今後実装したい機能
・グループ機能を作り、地域ごとにさらに細分化したコミュニティを作る。 
・各観光スポットのおすすめ情報を地図情報に紐付ける。  
・ユーザーの位置情報を基に適切なハッシュタグを提示する機能を実装する。  
・地図情報の表示を島単位からロケーション単位に変更して、星つけをする。

# DB設計
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
