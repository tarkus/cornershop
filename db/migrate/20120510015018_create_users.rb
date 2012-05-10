class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :team
      t.string :position
      t.string :phone
      t.integer :rental_count
      t.integer :overdue_count

      t.timestamps
    end
  end
end
