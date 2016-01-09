# coding: utf-8
class DashboardsController < ApplicationController
  def index
    reload
  end

  def reload
    UserDataHistory.update_user_data
    
    if !current_user.blank?
      if !current_user.user_data_histories.blank?
        latest_data = current_user.user_data_histories.order(:created_at).last
        # 最新の体重
        @latest_body_mass = latest_data.body_mass
        # 最新の歩数
        @latest_steps = latest_data.steps
        # メッセージの履歴
        @message_histories = MessageHistory.all
      else
        # 最新の体重
        @latest_body_mass = "----"
        # 最新の歩数
        @latest_steps = "----"
        # メッセージの履歴
        @message_histories = nil
      end
    end
  end
end
