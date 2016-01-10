class AddColumnsToMessageHistories < ActiveRecord::Migration
  def change
    add_column :message_histories, :achievement_categories, :int
    add_column :message_histories, :achievement_level,      :int
  end
end
