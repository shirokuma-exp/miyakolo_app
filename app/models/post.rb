class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags
  validate :image_presence
  after_commit :create_hash_tags, on: :create
  has_many :map

  def image_presence
    errors.add(:image, "写真を追加してください") unless image.attached?
  end

  def create_hash_tags
    extract_name_hash_tags.each do |name|
      hash_tags.create(name: name)
    end
  end

  def extract_name_hash_tags
    description.to_s.scan(/#\w+/).map{|name| name.gsub("#","")}
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :island
end