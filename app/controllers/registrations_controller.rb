class RegistrationsController < Devise::RegistrationsController
  def create
    service = ::Registration.new(user_params:, agency_params:).call

    if service.success?
      sign_in service.user
      redirect_to dashboard_path, status: :see_other, notice: "Welcome to #{service.agency.name}!"
    else
      @user = service.user
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end

  def agency_params
    params.require(:user).permit(:agency_name, :agency_timezone)
          .transform_keys { |k| k.sub("agency_", "") }
  end
end
