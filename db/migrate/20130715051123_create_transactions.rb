class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :notify_id
      t.float :total_fee
      t.string :trade_status
      t.string :out_trade_no
      t.datetime :notify_time

      t.timestamps
    end
  end
end
