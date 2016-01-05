class CreateMessageHistories < ActiveRecord::Migration
  def change
    create_table :message_histories do |t|
      t.integer :leaders_id, null: false
      t.integer :users_id,   null: false
      t.text    :message

      t.timestamps null: false
    end
  end
end
