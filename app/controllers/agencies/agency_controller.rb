module Agencies
  class AgencyController < BaseController
    def show
    end

    def update
      if current_agency.update(agency_params)
        success_respond("Successfully saved!", "Your agency settings have been updated.", agency_path)
      else
        failed_respond("Couldn't save", current_agency.errors.full_messages.to_sentence, agency_path)
      end
    end

    private

    def agency_params
      params.require(:agency).permit(:name, :timezone)
    end
  end
end
