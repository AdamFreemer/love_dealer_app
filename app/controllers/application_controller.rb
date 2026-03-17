class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  private

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_customers_path : customer_path
  end

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Not authorized."
    end
  end
end
