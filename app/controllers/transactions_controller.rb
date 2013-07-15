# coding: utf-8
class TransactionsController < ApplicationController
  def done
    flash[:notice] = "transaction done!"
    redirect_to :root
  end

  def checkout
    @partner_id = Settings.alipay.pid
    @key = Settings.alipay.secret
    @seller_email = Settings.alipay.seller_email # this is also account name

    @merchant = AlipayDualfun::Merchant.new(@partner_id, @key)

    @order_id = Time.now.to_i.to_s # 商家内部唯一订单编号
    @subject = params[:subject].blank? ? 'A Donkey':params[:subject] # 订单标题
    @description = params[:description].blank? ? 'Lovely':params[:description] # 订单内容

    @price = params[:price].blank? ? '0.01':params[:price]
    @quantity = params[:quantity].blank? ? '1':params[:quantity]

    @order = @merchant.create_order(@order_id, @subject, @description)
    @dualfun_pay = @order.seller_email(@seller_email).no_logistics.set_price_and_quantity(@price, @quantity).dualfun_pay

    # 交易成功同步返回地址
    @return_url = Settings.alipay.return_url
    @dualfun_pay.after_payment_redirect_url(@return_url)
    @notify_url = Settings.alipay.notify_url
    @dualfun_pay.notification_callback_url(@notify_url)

    redirect_to @dualfun_pay.gateway_api_url

  end
end
