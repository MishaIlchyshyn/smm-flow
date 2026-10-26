module Agencies
  class ClientsController < BaseController
    before_action :set_client, only: [:show, :update, :destroy]

    def index
      @clients = current_agency.clients.ordered
    end

    def show
      @projects = @client.projects.ordered
    end

    def new
      @client = current_agency.clients.build
      redirect_to clients_path unless turbo_frame_request?
    end

    def create
      @client = current_agency.clients.build(client_params)

      if @client.save
        @clients = current_agency.clients.ordered
        success_respond("Successfully saved!", "Client has been created.", clients_path)
      else
        failed_respond("Couldn't save", errors_msg(@client), clients_path)
      end
    end

    def update
      if @client.update(client_params)
        success_respond("Successfully saved!", "Client has been updated.", client_path(@client))
      else
        failed_respond("Couldn't save", errors_msg(@client), client_path(@client))
      end
    end

    def destroy
      @client.destroy
      redirect_to clients_path, notice: "Client deleted.", status: :see_other
    end

    private

    def set_client
      @client = current_agency.clients.find(params[:id])
    end

    def client_params
      params.require(:client).permit(
        :business_name, :owner_name, :email, :phone, :instagram_url, :source, :source_detail, :kind
      )
    end
  end
end
