class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :follow_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :follows, through: :follow_relationships
  has_many :follower_relationships, foreign_key: "follow_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :homes

  def follow?(other_user)
    follow_relationships.find_by(follow_id: other_user.id)
  end

  def follow!(other_user)
    follow_relationships.create!(follow_id: other_user.id)
  end

  def unfollow!(other_user)
    follow_relationships.find_by(follow_id: other_user.id).destroy
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
