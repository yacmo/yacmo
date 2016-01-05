class RenameUserIdColumnToUserDataHistories < ActiveRecord::Migration
  def change
    rename_column :user_data_histories, :users_id, :user_id
  end
end
