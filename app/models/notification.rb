class Notification < ActiveRecord::Base
  attr_accessible :notify_time, :out_trade_no, :total_fee
end
