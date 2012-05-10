class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :team
      t.string :position
      t.string :phone
      t.string :nationality
      t.integer :rental_count
      t.integer :overdue_count

      t.timestamps
    end

		add_index :users, :name
		add_index :users, :surname
		add_index :users, :rental_count
		add_index :users, :overdue_count
  end
end
