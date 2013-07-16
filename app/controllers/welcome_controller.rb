class WelcomeController < ApplicationController
  def index
    @transactions = Transaction.all
    @notifications = Notification.all
  end
end
