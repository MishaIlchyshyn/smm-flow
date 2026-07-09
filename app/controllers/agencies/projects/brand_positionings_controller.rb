module Agencies
  module Projects
    class BrandPositioningsController < BaseController
      before_action :set_project

      def update
        @brand_positioning = @project.brand_positioning || @project.build_brand_positioning

        if @brand_positioning.update(brand_positioning_params)
          success_respond("Successfully saved!", "Brand positioning has been updated.",
                           project_path(@project, tab: "brand_positioning"))
        else
          failed_respond("Couldn't save", errors_msg(@brand_positioning),
                          project_path(@project, tab: "brand_positioning"))
        end
      end

      private

      def set_project
        @project = current_agency.projects.find(params[:project_id])
      end

      def brand_positioning_params
        raw = params.require(:brand_positioning)

        raw.permit(:brand_name, :industry, :target_audience, :tone_of_voice,
                   :usp, :goals, :competitors, :visual_style_notes)
           .merge(brand_values: split_list(raw[:brand_values]), avoid_topics: split_list(raw[:avoid_topics]))
      end

      def split_list(value)
        value.to_s.split(",").map(&:strip).reject(&:blank?)
      end
    end
  end
end
