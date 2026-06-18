module Agencies
  module Profile
    class PasswordController < Agencies::BaseController
      def update
        if current_user.update_with_password(password_params)
          bypass_sign_in(current_user)
          redirect_to profile_path(tab: :password), notice: "Password updated successfully."
        else
          redirect_to profile_path(tab: :password), alert: current_user.errors.full_messages.to_sentence
        end
      end

      private

      def password_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end
    end
  end
end
