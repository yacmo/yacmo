class RenameLeadersIdColumnToMessageHistories < ActiveRecord::Migration
  def change
    rename_column :message_histories, :leaders_id, :leader_id
  end
end
