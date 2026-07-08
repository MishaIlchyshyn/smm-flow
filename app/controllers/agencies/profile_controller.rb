module Agencies
  class ProfileController < BaseController
    def show
    end

    def update
      if current_user.update(user_params)
        success_respond("Successfully saved!", "Your profile has been updated.", profile_path(tab: :base_settings))
      else
        failed_respond("Couldn't save", errors_msg(current_user), profile_path(tab: :base_settings))
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :full_name)
    end
  end
end
