class AddConnectionInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :consumer_key,    :string
    add_column :users, :consumer_secret, :string
    add_column :users, :token,           :string
    add_column :users, :secret,          :string
    add_column :users, :fitgem_user_id,  :string
  end
end
