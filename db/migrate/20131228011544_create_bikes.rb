class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :text
      t.string :href
      t.string :price
      t.string :location
      t.boolean :has_img

      t.timestamps
    end
  end
end
