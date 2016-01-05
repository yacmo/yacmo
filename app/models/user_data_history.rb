#  id         :integer  not null
#  users_id   :integer  not null
#  steps      :integer  not null
#  body_mass  :float    not null
#  created_at :datetime
#  updated_at :datetime

class UserDataHistory < ActiveRecord::Base
  belongs_to :users
end
