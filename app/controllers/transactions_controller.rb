# coding: utf-8
class TransactionsController < ApplicationController
  before_filter :create_transaction, :only => [:done, :notify]

  def create_transaction
    transaction = Transaction.find_by_out_trade_no(params[:out_trade_no])
    if params[:trade_status] == 'TRADE_FINISHED' && transaction.nil?
      transaction = Transaction.new(notify_id: params[:notify_id], total_fee: params[:total_fee], out_trade_no: params[:out_trade_no], trade_status: params[:trade_status], notify_time: params[:notify_time])
      transaction.save!
    end
  end

  def done
    flash[:notice] = "付款成功啦!"
    redirect_to :root
  end

  def notify
    render text: 'success'
  end

  def checkout
    options = {
      :partner           => Settings.alipay.pid,
      :key               => Settings.alipay.secret,
      :seller_email      => Settings.alipay.seller_email,
      :description       => 'Lovely description',
      :out_trade_no      => Time.now.to_i.to_s,
      :subject           => 'YOUR_ORDER_SUBJECCT',
      :price             => params[:price],
      :quantity          => params[:quantity],
      :discount          => '0.00',
      :return_url        => Settings.alipay.return_url,
      :notify_url        => Settings.alipay.notify_url
    }

    redirect_to AlipayDualfun.trade_create_by_buyer_url(options)
  end
end
