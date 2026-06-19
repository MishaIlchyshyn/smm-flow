module Agencies
  class AgencyController < BaseController
    def show
    end

    def update
      if current_agency.update(agency_params)
        redirect_to agency_path, notice: "Agency updated successfully."
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def agency_params
      params.require(:agency).permit(:name, :timezone)
    end
  end
end
