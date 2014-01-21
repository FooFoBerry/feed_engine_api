module Api
  module V1
    class ReposController < ApplicationController
      before_action :get_project, only: [:index, :show, :create]

      def index
        repos = @project.repos
        render json: repos
      end

      def show
        repo = @project.repos.find(params[:id])
        render json: repo
      end

      def create
        repo = Repo.find_or_create_by(repo_params)
        @project.repos << repo if repo.valid? && !@project.repos.include?(repo)
        if repo.valid?
          render json: repo, :status => 201
        else
          render json: repo_errors(repo), :status => 422
        end
      end

      private

      def get_project
        @project = Project.find(params[:project_id])
      end

      def repo_errors(repo)
        messages = repo.errors.messages
        errors_hash = { "errors" => messages }
      end

      def repo_params
        body, url = params[:repo][:github_url].downcase.split('/')[-2..-1]
        params[:repo][:github_url] = "#{body}/#{url}"
        params.require(:repo).permit(:github_url)
      end

    end
  end
end
