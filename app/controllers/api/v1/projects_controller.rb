module Api
  module V1
    class ProjectsController < ApplicationController

      def index
        user_id = params[:user_id]
        render json: Project.where(:user_id => user_id)
      end

      def show
        render json: Project.find(params[:id])
      end

      def create
        project = Project.new(project_params)
        if project.save
          render json: project, :status => 201
        else
          render json: project_errors(project), :status => 422
        end
      end

      private

      def project_errors(project)
        messages = project.errors.messages
        errors_hash = { "errors" => messages }
      end

      def project_params
        params.require(:project).permit(:name, :user_id)
      end

    end
  end
end
