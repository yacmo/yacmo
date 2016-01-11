class AddColumnDateToUserDataHistories < ActiveRecord::Migration
  def change
    add_column :user_data_histories, :date, :date
    add_index :user_data_histories, [:date, :user_id], unique: true, name: :user_data_histories_unique_in
    UserDataHistory.all.each { |udh| udh.update!(date: udh.created_at.to_date) }
    change_column :user_data_histories, :date, :date, null: false
  end
end
