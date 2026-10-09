class RegistrationsController < Devise::RegistrationsController
  def create
    service = ::Registration.new(user_params:).call

    if service.success?
      sign_in service.user
      redirect_to clients_path, status: :see_other, notice: "Welcome to #{service.agency.name}!"
    else
      @user = service.user
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
