# coding: utf-8
class DashboardsController < ApplicationController
  def show
    if !current_user.blank?
      # 最新の情報を取得
      @user_data_history = current_user.
        user_data_histories.
        order('date DESC').
        first
      @user_data_history ||= current_user.user_data_histories.new
      # メッセージの履歴
      @message_histories = get_message_histories
    end
  end

  def reload
    current_user.fetch_today

    redirect_to dashboard_path
  end

  def create_message
  end

  def get_message_histories
    MessageHistory.all
  end
end
