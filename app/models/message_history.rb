#  id         :integer  not null, primary key
#  leader_id :integer  not null
#  user_id   :integer  not null
#  message    :text
#  created_at :datetime
#  updated_at :datetime

class MessageHistory < ActiveRecord::Base
end
