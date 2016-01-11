class AddColumnStartWeightToUsers < ActiveRecord::Migration
  def change
    add_column :users, :start_weight, :float
  end
end
