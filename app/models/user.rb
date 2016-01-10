# -*- coding: utf-8 -*-
#  id              :integer  not null
#  email           :string   not null
#  created_at      :datetime
#  updated_at      :datetime
#  consumer_key    :string
#  consumer_secret :string
#  token           :string
#  secret          :string
#  fitgem_user_id  :string

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

    ################## 体重 ######################
    # 体重の取得
    weight = client.user_info['user']["weight"] * 0.453592
    # 目標体重
    # client.body_weight_goal["weight"]

    # 目標体重
    weight_goal = client.body_weight_goal["goal"]["weight"]
    # 開始日時
    # client.body_weight_goal["goal"]["startDate"]
    # 開始時の体重
    start_weight = client.body_weight_goal["goal"]["startWeight"]
    # 現在の体重
    current_weight = client.user_info['user']["weight"]
    # 体重の達成度
    @weight_achievement = (start_weight - current_weight) / (start_weight - weight_goal ) * 100
    
    ################## 歩数 ######################
    # 歩数の取得
    activities = client.activities_on_date('today')
    steps = activities["summary"]["steps"]
    p "歩数: #{steps}"
    # 歩数の目標
    steps_achievement = steps / activities["goals"]["steps"] * 100
    p "歩数達成度: #{steps_achievement}"

    # 履歴の作成
    UserDataHistory.create(user_id: self.id, steps: steps, body_mass: weight)
  end
end
