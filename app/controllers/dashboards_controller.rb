# coding: utf-8
class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    create_message
    # 最新の情報を取得
    @user_data_history = current_user.
      user_data_histories.
      order('date DESC').
      first
    @user_data_history ||= current_user.user_data_histories.new
    # メッセージの履歴
    @message_histories = get_message_histories
  end

  def reload
    begin
      current_user.fetch_today
    rescue => e
      p "更新処理に失敗しました: #{e}"
    end
    redirect_to dashboard_path
  end

  def create_message
    MessageHistory.create_daily_step_message(current_user.id)
    MessageHistory.create_weight_message(current_user.id)
  end

  def get_message_histories
    MessageHistory.all
  end
end
