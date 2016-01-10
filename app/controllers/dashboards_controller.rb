# coding: utf-8
class DashboardsController < ApplicationController
  def index
    reload
  end

  def reload
    if !current_user.blank?
      # 最新の情報を取得
      client = get_latest_status
      # ステータスをセット
      set_status(client)
      # メッセージの履歴
      @message_histories = get_message_histories

      get_steps_achievement(client)
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

  def set_status(client)
    if !client.blank?
      # 最新の体重
      @latest_body_mass = (client.user_info['user']["weight"] * 0.453592).round(1)
      # 体重の達成度
      @weight_achievement = get_weight_achievement(client).round(1)
      # 最新の歩数
      @latest_steps = client.activities_on_date('today')["summary"]["steps"]
      # メッセージの履歴
      @message_histories = MessageHistory.all
    else
      # 最新の体重
      @latest_body_mass = "----"
      # 体重の達成度
      @weight_achievement = "----"
      # 最新の歩数
      @latest_steps = "----"
      # メッセージの履歴
      @message_histories = nil
    end
  end

  def create_message
  end

  def get_message_histories
    MessageHistory.all
  end

  def get_steps_achievement(client)
    steps_achievement = client.activities_on_date('today')["goals"]["steps"]
    # 歩数の取得
    latest_steps = client.activities_on_date('today')["goals"]["steps"]
    latest_steps / steps_achievement
  end

  def get_weight_achievement(client)
    # 目標体重
    weight_goal = client.body_weight_goal["goal"]["weight"]
    # 開始日時
    # client.body_weight_goal["goal"]["startDate"]
    # 開始時の体重
    start_weight = client.body_weight_goal["goal"]["startWeight"]
    # 現在の体重
    current_weight = client.user_info['user']["weight"]
    # 体重の達成度
    ((start_weight - current_weight) / (start_weight - weight_goal ) * 100)
  end
end
