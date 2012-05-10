class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.string :description
      t.string :type
      t.integer :release_year
      t.string :language
      t.string :producer
      t.string :cast
      t.string :location
      t.integer :availability

      t.timestamps
    end
  end
end
