# -*- coding: utf-8 -*-
#  id         :integer  not null
#  user_id   :integer  not null
#  steps      :integer  not null
#  body_mass  :float    not null
#  created_at :datetime
#  updated_at :datetime

class UserDataHistory < ActiveRecord::Base
  belongs_to :users

  def self.update_user_data
    config = begin
               Fitgem::Client.symbolize_keys(YAML.load(File.open("/home/kaname/development/independent_research/yacmo/config/.fitgem.yml")))
             rescue ArgumentError => e
               puts "Cud not parse YAMLE: #{e.message}"
             end

    client = Fitgem::Client.new(config[:oauth])

    if config[:oauth][:token] && config[:oauth][:secret]
      begin
        client.reconnect(config[:oauth][:token], config[:oauth][:secret])
      rescue Exception => e
        puts "Error: .fitgem.ymlのkeyが不正です。Fitgem::Clientへ再接続できません"
        return
      end
    else
      puts "Fitgem::Clientの初期化を行ってください"
      return
    end

    # activities = client.activities_on_date('today')
    # puts activities

    # friendの情報の取得方法
    # puts client.friends
    # user_infoの取得方法
    # puts client.user_info['user']
  end
end
