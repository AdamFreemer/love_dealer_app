class RegistrationsController < ApplicationController
  layout "landing"

  def create
    @user = User.find_by(email: user_params[:email]) || User.new(user_params)

    if @user.persisted? && @user.encrypted_password.present?
      redirect_to new_user_session_path, alert: "An account with that email already exists. Please log in."
      return
    end

    @user.assign_attributes(user_params) unless @user.new_record?
    @user.intake_token = SecureRandom.urlsafe_base64(32)
    @user.status = :under_review

    if @user.save
      session[:intake_token] = @user.intake_token
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to intake_path, notice: "Application received!" }
      end
    else
      @services = Service.all
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("registration_form", partial: "pages/form", locals: { user: @user, services: @services }) }
        format.html { render "pages/home", status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :gender, :seeking, :about, service_ids: [])
  end
end
