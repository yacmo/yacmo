# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_data_histories

  def update_user_data
    user_token = {
      :consumer_key => self.consumer_key,
      :consumer_secret => self.consumer_secret,
      :token => self.token,
      :secret => self.secret
    }

    client = Fitgem::Client.new(user_token)

    # id
    p "id: #{self.id}"
    # 体重の取得
    weight = client.user_info['user']["weight"] * 0.453592
    p "体重: #{weight}"
    # 歩数の取得
    activities = client.activities_on_date('today')
    steps = activities["summary"]["steps"]
    p "歩数: #{steps}"

    UserDataHistory.create(user_id: self.id, steps: steps, body_mass: weight)
  end
end
