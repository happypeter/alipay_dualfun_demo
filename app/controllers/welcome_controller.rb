class WelcomeController < ApplicationController
  def index
    @transactions = Transanction.all
  end
end
