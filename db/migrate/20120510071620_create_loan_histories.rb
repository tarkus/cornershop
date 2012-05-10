class CreateLoanHistories < ActiveRecord::Migration
  def change
    create_table :loan_histories do |t|
      t.references :user
      t.references :media
      t.date :rent_start
      t.date :rent_estimated
      t.date :rent_effective

      t.timestamps
    end

		add_index :loan_histories, :user_id
		add_index :loan_histories, :media_id
		add_index :loan_histories, :rent_start
		add_index :loan_histories, :rent_effective
  end
end
