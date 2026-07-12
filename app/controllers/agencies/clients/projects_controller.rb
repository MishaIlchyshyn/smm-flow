module Agencies
  module Clients
    class ProjectsController < BaseController
      before_action :set_client
      before_action :set_project, only: [:show, :update, :destroy]

      def new
        @project = @client.projects.build
        redirect_to client_path(@client, tab: "projects") unless turbo_frame_request?
      end

      def create
        @project = @client.projects.build(project_params.merge(agency: current_agency))

        if @project.save
          success_respond("Successfully saved!", "Project has been created.", client_project_path(@client, @project))
        else
          failed_respond("Couldn't save", errors_msg(@project), new_client_project_path(@client))
        end
      end

      def show
        redirect_to client_path(@client, tab: "projects") unless turbo_frame_request?
      end

      def update
        if @project.update(project_params)
          success_respond("Successfully saved!", "Project has been updated.", client_project_path(@client, @project))
        else
          failed_respond("Couldn't save", errors_msg(@project), client_project_path(@client, @project))
        end
      end

      def destroy
        @project.destroy
        redirect_to client_path(@client, tab: "projects"), status: :see_other
      end

      private

      def set_client
        @client = current_agency.clients.find(params[:client_id])
      end

      def set_project
        @project = @client.projects.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :status, :started_at, :ended_at)
      end
    end
  end
end
