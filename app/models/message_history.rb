# -*- coding: utf-8 -*-
#  id                     :integer  not null, primary key
#  leader_id              :integer  not null
#  user_id                :integer  not null
#  message                :text
#  created_at             :datetime
#  updated_at             :datetime
#  date                   :date
#  achievement_categories :integer
#  achievement_level      :integer

class MessageHistory < ActiveRecord::Base
  # 達成度種別
  ACHIEVEMENT_CATEGORIES = {
    steps: 0,
    weight: 1
  }
  # 達成度
  ACHIEVEMENT_LEVEL = {
    'half': 50,
    'soon': 80,
    'achieved': 100
  }
  ACHIEVEMENT_LEVEL_NAME = {
    half: "半分",
    soon: "もうちょっと",
    achieved: "達成"
  }

  def self.create_weight_message(user_id)
    today = Date.today.strftime('%Y-%m-%d')
    weight_achivement = UserDataHistory.where(date: today, user_id: user_id).take.weight_achievement

    values = {
      leader_id: 0,
      user_id: user_id,
      date: today,
      achievement_categories: 1
    }

    # 既に50%達成のメッセージが存在する場合
    if mh = MessageHistory.where(user_id: user_id, date: today, achievement_level: 50, achievement_categories: 1).take
    else
      # 体重減量の達成度が50%を超えている場合
      if weight_achivement >= 50
        message = '体重減量の目標を半分達成しました!!'
        MessageHistory.create(values.merge(achievement_level: 50, message: message))
      end
    end
  end
  
  def self.create_daily_step_message(user_id)
    today = Date.today.strftime('%Y-%m-%d')
    steps_achivement = UserDataHistory.where(date: today, user_id: user_id).take.steps_achievement

    values = {
      leader_id: 0,
      user_id: user_id,
      date: today,
      achievement_categories: 0
    }
    
    # 既に50%達成のメッセージが存在する場合
    if mh = MessageHistory.where(user_id: user_id, date: today, achievement_level: 50, achievement_categories: 0).take
    else
      # 歩数の達成度が50%を超えている場合
      if steps_achivement >= 50
        message = '歩数の目標を半分達成しました!!'
        message_histories.create(values.merge(achievement_level: 50, message: message))
      end
    end
  end
end
