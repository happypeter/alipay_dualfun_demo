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

    @order_id = '20140505' # 商家内部唯一订单编号
    @subject = 'MyEp' # 订单标题
    @description = 'hello' # 订单内容
    @order = @merchant.create_order(@order_id, @subject, @description)
    @dualfun_pay = @order.seller_email(@seller_email).no_logistics.set_price_and_quantity('2', '3').dualfun_pay

    # 交易成功同步返回地址
    @return_url = Settings.alipay.return_url
    @dualfun_pay.after_payment_redirect_url(@return_url)
    @notify_url = Settings.alipay.notify_url
    @dualfun_pay.notification_callback_url(@notify_url)

    redirect_to @dualfun_pay.gateway_api_url

  end
end
