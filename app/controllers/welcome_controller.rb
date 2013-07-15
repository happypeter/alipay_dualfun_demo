class WelcomeController < ApplicationController
  def index
    @transactions = Transacton.all
  end
end
