class AddColumnGoalsToUserDataHistories < ActiveRecord::Migration
  def change
    add_column :user_data_histories, :steps_goal, :integer
    add_column :user_data_histories, :weight_goal, :float
  end
end
