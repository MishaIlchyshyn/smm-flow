module Agencies
  module Projects
    class ContentPlanItemsController < BaseController
      before_action :set_project
      before_action :set_content_plan_item, only: [:show, :update, :destroy]

      def new
        @content_plan_item = @project.content_plan_items.build
        redirect_to project_path(@project, tab: "content_planning") unless turbo_frame_request?
      end

      def create
        @content_plan_item = @project.content_plan_items.build(content_plan_item_params)

        if @content_plan_item.save
          success_respond("Successfully saved!", "Content plan has been created.",
                           project_content_plan_item_path(@project, @content_plan_item))
        else
          failed_respond("Couldn't save", errors_msg(@content_plan_item),
                          new_project_content_plan_item_path(@project))
        end
      end

      def show
        redirect_to project_path(@project, tab: "content_planning") unless turbo_frame_request?
      end

      def update
        if @content_plan_item.update(content_plan_item_params)
          success_respond("Successfully saved!", "Content plan has been updated.",
                           project_content_plan_item_path(@project, @content_plan_item))
        else
          failed_respond("Couldn't save", errors_msg(@content_plan_item),
                          project_content_plan_item_path(@project, @content_plan_item))
        end
      end

      def destroy
        @content_plan_item.destroy
        redirect_to project_path(@project, tab: "content_planning"), status: :see_other
      end

      private

      def set_project
        @project = current_agency.projects.find(params[:project_id])
      end

      def set_content_plan_item
        @content_plan_item = @project.content_plan_items.find(params[:id])
      end

      def content_plan_item_params
        params.require(:content_plan_item).permit(:platform, :content_type, :title, :scheduled_for,
                                                    :status, :caption_draft, :visual_notes)
      end
    end
  end
end
