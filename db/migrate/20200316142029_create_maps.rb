class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.belongs_to :hash_tag,index: true
      t.belongs_to :post,index: true
      t.string :region
      t.timestamps
    end
  end
end
