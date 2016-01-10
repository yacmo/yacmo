# coding: utf-8
class DashboardsController < ApplicationController
  def index
    reload
  end

  def reload
    if !current_user.blank?
      if !current_user.user_data_histories.blank?
        # 最新の情報を取得
        client = get_latest_status
        # 最新の体重
        @latest_body_mass = (client.user_info['user']["weight"] * 0.453592).round(1)
        # 体重の達成度
        @weight_achievement = get_weight_achievement(client).round(1)
        # 最新の歩数
        @latest_steps = client.activities_on_date('today')["summary"]["steps"]
        # メッセージの履歴
        @message_histories = MessageHistory.all
        # 週刊目標
        get_weekly_goals(client)
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

  def get_latest_status
    user_token = {
      :consumer_key => current_user.consumer_key,
      :consumer_secret => current_user.consumer_secret,
      :token => current_user.token,
      :secret => current_user.secret
    }

    Fitgem::Client.new(user_token)
  end

  def get_weekly_goals(client)
    p client.weekly_goals
  end

  def get_weight_achievement(client)
    # 目標体重
    p weight_goal = client.body_weight_goal["goal"]["weight"]
    # 開始日時
    # client.body_weight_goal["goal"]["startDate"]
    # 開始時の体重
    p start_weight = client.body_weight_goal["goal"]["startWeight"]
    # 現在の体重
    p current_weight = client.user_info['user']["weight"]
    # 体重の達成度
    ((start_weight - current_weight) / (start_weight - weight_goal ) * 100)
  end
end
