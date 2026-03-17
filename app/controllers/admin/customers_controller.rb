module Admin
  class CustomersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
    layout "admin"

    def index
      @customers = User.where(admin: false).order(created_at: :desc)
    end

    def show
      @customer = User.find(params[:id])
    end

    def edit
      @customer = User.find(params[:id])
    end

    def update
      @customer = User.find(params[:id])
      if @customer.update(customer_params)
        redirect_to admin_customer_path(@customer), notice: "Customer updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def customer_params
      params.require(:user).permit(:status, :admin_notes, :first_name, :last_name, :email, :phone, :location)
    end
  end
end
