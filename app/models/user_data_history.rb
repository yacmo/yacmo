# -*- coding: utf-8 -*-
#  id         :integer  not null
#  user_id    :integer  not null
#  steps      :integer  not null
#  weight     :float
#  created_at :datetime
#  updated_at :datetime

class UserDataHistory < ActiveRecord::Base
  belongs_to :user

  def steps_achievement
    steps.to_f / steps_goal * 100 rescue nil
  end

  def weight_achievement
    (user.start_weight - weight) / (user.start_weight - weight_goal) * 100 rescue nil
  end
end
