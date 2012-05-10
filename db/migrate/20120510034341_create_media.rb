class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.string :type
      t.integer :year
      t.string :language
      t.string :producer
      t.string :artist
      t.string :cast
      t.string :location
      t.integer :availability

      t.timestamps
    end

		add_index :media, :title
		add_index :media, :cast
  end
end
