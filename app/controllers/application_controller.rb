class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :authenticate_user!

  helper_method :current_agency

  stale_when_importmap_changes

  private

  def current_agency
    @current_agency ||= current_user&.agency
  end

  def after_sign_in_path_for(resource)
    clients_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
