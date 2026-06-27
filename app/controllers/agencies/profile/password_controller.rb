module Agencies
  module Profile
    class PasswordController < Agencies::BaseController
      def update
        if current_user.update_with_password(password_params)
          bypass_sign_in(current_user)
          success_respond(
            "Password updated!",
            "Your password has been changed successfully.",
            profile_path(tab: :password)
          )
        else
          failed_respond(
            "Couldn't update password",
            errors_msg(current_user),
            profile_path(tab: :password)
          )
        end
      end

      private

      def password_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end
    end
  end
end
