# coding: utf-8
class TransactionsController < ApplicationController
  def done
    flash[:notice] = "transaction done!"
    redirect_to :root
  end
end
