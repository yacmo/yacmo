class AddColumnToMessageHistories < ActiveRecord::Migration
  def change
    add_column :message_histories, :date, :date
    add_index :message_histories, [:date, :user_id], unique: true, name: :message_histories_unique_in
    MessageHistory.all.each { |mh| mh.update!(date: mh.created_at.to_date) }
    change_column :message_histories, :date, :date, null: false
  end
end
