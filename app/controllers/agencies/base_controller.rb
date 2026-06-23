module Agencies
  class BaseController < ApplicationController
    layout "agency"

    private

    def success_respond(title, msg, redirect_path)
      @toast_data = { kind: "success", title:, msg: }

      respond_to do |format|
        format.turbo_stream { render action_name, status: :ok }
        format.html { redirect_to redirect_path, notice: title }
      end
    end

    def failed_respond(title, msg, redirect_path)
      @toast_data = { kind: "error", title:, msg: }

      respond_to do |format|
        format.turbo_stream { render action_name, status: :unprocessable_entity }
        format.html { redirect_to redirect_path, alert: title }
      end
    end
  end
end
