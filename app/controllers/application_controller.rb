class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :set_current_agency

  helper_method :current_agency

  stale_when_importmap_changes

  private

  def current_agency
    @agency
  end

  def set_current_agency
    return unless user_signed_in?

    @agency ||= current_user.agencies.order("memberships.created_at ASC").first

    if @agency.nil?
      sign_out current_user
      redirect_to new_user_session_path, alert: "No agency found for this account. Please sign up again."
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
