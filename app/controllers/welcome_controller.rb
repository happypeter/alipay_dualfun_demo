class WelcomeController < ApplicationController
  def index
    @transactions = Transaction.all
  end
end
