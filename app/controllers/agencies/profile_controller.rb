module Agencies
  class ProfileController < BaseController
    def show
    end

    def update
      if current_user.update(user_params)
        redirect_to profile_path, notice: "Profile updated successfully."
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :full_name)
    end
  end
end
