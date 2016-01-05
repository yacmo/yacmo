#  id         :integer  not null, primary key
#  leaders_id :integer  not null
#  users_id   :integer  not null
#  message    :text
#  created_at :datetime
#  updated_at :datetime

class DashboardsController < ApplicationController
  def index
    @user_data_histories = UserDataHistory.last
    @message_histories = MessageHistory.all
  end
end
