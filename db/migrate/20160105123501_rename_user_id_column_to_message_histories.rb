class RenameUserIdColumnToMessageHistories < ActiveRecord::Migration
  def change
    rename_column :message_histories, :users_id, :user_id
  end
end
