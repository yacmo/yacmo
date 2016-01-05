class CreateUserDataHistories < ActiveRecord::Migration
  def change
    create_table :user_data_histories do |t|
      t.integer :users_id,  null: false
      t.integer :steps,     null: false
      t.float   :body_mass, null: false

      t.timestamps null: false
    end
  end
end
