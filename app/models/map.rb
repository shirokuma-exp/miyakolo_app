class Map < ApplicationRecord
  belongs_to :post
  belongs_to :hash_tag

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :island
end
