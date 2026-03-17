class IntakesController < ApplicationController
  layout "landing"
  before_action :find_user

  def show
  end

  def update
    if @user.update(intake_params)
      if intake_params[:password].present?
        sign_in(@user)
      end
      redirect_to customer_path, notice: "Thank you for completing your profile!"
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = if current_user
              current_user
    elsif session[:intake_token].present?
              User.find_by!(intake_token: session[:intake_token])
    else
              redirect_to root_path, alert: "Please submit the basic form first."
    end
  end

  def intake_params
    params.require(:user).permit(
      :phone, :location, :life_stage, :emotional_availability,
      :jewish, :jewish_identity, :cultural_values, :political_view,
      :alcohol_use, :smoking, :marijuana_use,
      :neurodivergent, :neurodivergent_details,
      :upbringing, :grief_or_loss, :relationship_patterns,
      :partner_goals, :relationship_qualities,
      :comfort_lifestyle, :luxury_relationship,
      :open_to_relocating, :interest_level, :open_to_zoom_consultation,
      :agrees_to_consultation, :agrees_to_no_guarantee,
      :password, :password_confirmation
    )
  end
end
