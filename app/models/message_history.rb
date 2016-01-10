# -*- coding: utf-8 -*-
#  id         :integer  not null, primary key
#  leader_id :integer  not null
#  user_id   :integer  not null
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#  achievement_categories :integer
#  achievement_level      :integer

class MessageHistory < ActiveRecord::Base
  ACHIEVEMENT_CATEGORIES = {
    steps: 0,
    weight: 1
  }
  ACHIEVEMENT_LEVEL = {
    half: 50,
    soon: 80,
    achieved: 100
  }
  ACHIEVEMENT_LEVEL_NAME = {
    half: "半分",
    soon: "もうちょっと",
    achieved: "達成"
  }
end
