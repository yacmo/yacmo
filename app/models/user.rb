# -*- coding: utf-8 -*-
#  id              :integer  not null
#  email           :string   not null
#  created_at      :datetime
#  updated_at      :datetime
#  consumer_key    :string
#  consumer_secret :string
#  token           :string
#  secret          :string
#  fitgem_user_id  :string

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_data_histories

  def fetch_recent_datas
    from = 30.days.ago.to_date
    to = Date.today
    fetch_steps_on_range(from, to)['activities-steps'].each do |hash|
      date = hash['dateTime'] # YYYY-MM-DD 形式
      steps = hash['value']
      if udh = user_data_histories.where(date: date).take
        udh.update(steps: steps)
      else
        user_data_histories.create(date: date, steps: steps)
      end
    end
    (from..to).each do |date|
      weight = fetch_weight_on(date)
      next if weight.nil?
      if udh = user_data_histories.where(date: date).take
        udh.update(weight: weight)
      else
        user_data_histories.create(date: date, weight: weight)
      end
    end
  end

  def fetch_weight_on(date)
    values = fitgem_client.body_measurements_on_date(date.to_s(:db))
    User.lb2kg(values['body']['weight']) rescue nil
  end

  def fetch_steps_on_range(from, to)
    fitgem_client.activity_on_date_range('steps', from, to)
  end

  def fitgem_client
    Fitgem::Client.new(
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      token: token,
      secret: secret)
  end

  def self.lb2kg(lb)
    nil if lb.nil? || lb.zero?
    lb * 0.45359237
  end
end
