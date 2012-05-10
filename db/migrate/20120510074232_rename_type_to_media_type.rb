class RenameTypeToMediaType < ActiveRecord::Migration
  def up
		rename_column :media, :type, :media_type
  end

  def down
		rename_column :media, :media_type, :type
  end
end
