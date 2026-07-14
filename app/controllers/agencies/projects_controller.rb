module Agencies
  class ProjectsController < BaseController
    before_action :set_project, only: [:show, :update, :destroy]

    def index
      @projects = current_agency.projects.ordered.includes(:client)
    end

    def new
      @project = current_agency.projects.build
    end

    def create
      @project = current_agency.projects.build(project_params)

      if @project.save
        redirect_to project_path(@project, tab: "details"), notice: "Project created."
      else
        failed_respond("Couldn't save", errors_msg(@project), new_project_path)
      end
    end

    def show
      @brand_positioning = @project.brand_positioning || @project.build_brand_positioning
      @content_plan_items = @project.content_plan_items.ordered
    end

    def update
      if @project.update(project_params)
        success_respond("Successfully saved!", "Project has been updated.", project_path(@project, tab: "details"))
      else
        failed_respond("Couldn't save", errors_msg(@project), project_path(@project, tab: "details"))
      end
    end

    def destroy
      @project.destroy
      redirect_to projects_path, notice: "Project deleted.", status: :see_other
    end

    private

    def set_project
      @project = current_agency.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :status, :client_id, :started_at, :ended_at)
    end
  end
end
