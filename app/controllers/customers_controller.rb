class CustomersController < ApplicationController
  before_action :authenticate_user!
  layout "landing"

  def show
    @user = current_user
  end
end
