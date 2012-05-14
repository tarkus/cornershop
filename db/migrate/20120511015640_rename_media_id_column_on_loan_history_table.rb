class RenameMediaIdColumnOnLoanHistoryTable < ActiveRecord::Migration
  def up
		rename_column :loan_histories, :media_id, :medium_id
  end

  def down
		rename_column :loan_histories, :medium_id, :media_id
  end
end
