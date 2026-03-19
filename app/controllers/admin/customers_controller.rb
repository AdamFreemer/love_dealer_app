module Admin
  class CustomersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
    before_action :set_customer, only: [ :show, :edit, :update, :destroy ]
    layout "admin"

    def index
      @customers = User.where(admin: false).order(created_at: :desc)
    end

    def show
    end

    def edit
    end

    def update
      if @customer.update(customer_params)
        redirect_to admin_customer_path(@customer), notice: "Customer updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @customer.soft_delete!
      redirect_to admin_customers_path, notice: "#{@customer.full_name} has been deleted."
    end

    def batch_destroy
      ids = params[:customer_ids] || []
      users = User.where(id: ids, admin: false)
      count = users.count
      users.each(&:soft_delete!)
      redirect_to admin_customers_path, notice: "#{count} #{"customer".pluralize(count)} deleted."
    end

    private

    def set_customer
      @customer = User.find(params[:id])
    end

    def customer_params
      params.require(:user).permit(
        :status, :admin_notes,
        :first_name, :last_name, :email, :age, :gender, :seeking, :about,
        :phone, :location,
        :life_stage, :emotional_availability,
        :jewish, :jewish_identity, :cultural_values, :political_view,
        :alcohol_use, :smoking, :marijuana_use,
        :neurodivergent, :neurodivergent_details,
        :upbringing, :grief_or_loss, :relationship_patterns,
        :partner_goals, :relationship_qualities,
        :comfort_lifestyle, :luxury_relationship,
        :open_to_relocating, :interest_level, :open_to_zoom_consultation,
        :agrees_to_consultation, :agrees_to_no_guarantee
      )
    end
  end
end
