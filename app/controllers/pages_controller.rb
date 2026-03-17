class PagesController < ApplicationController
  layout "landing"

  def home
    @user = User.new
    @services = Service.all
  end
end
