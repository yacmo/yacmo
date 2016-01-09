# -*- coding: utf-8 -*-
#  id         :integer  not null
#  user_id   :integer  not null
#  steps      :integer  not null
#  body_mass  :float    not null
#  created_at :datetime
#  updated_at :datetime

class UserDataHistory < ActiveRecord::Base
  belongs_to :users

  def update_user_data
    config = begin
      Fitgem::Client.symbolize_keys(YAML.load(File.opne("../../config/.figem.yml")))
    rescue ArgumentError => e
      puts "Cud not parse YAMLE: #{e.message}"
    end

    client = Fitgem::Client.new(config[:oauth])

    if config[:oauth][:token] && config[:oauth][:secret]
      begin
        access_token = client.reconnect(config[:oauth][:token], config[:oauth][:secret])
      rescue Exception => e
        puts "Error: .fitgem.ymlのkeyが不正です。Fitgem::Clientへ再接続できません"
      end
    else
      puts "Fitgem::Clientの初期化を行ってください"
    end
  end
end
