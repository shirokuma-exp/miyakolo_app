class AddRegionToHashTag < ActiveRecord::Migration[5.2]
  def change
    add_column :hash_tags, :region, :string
  end
end
