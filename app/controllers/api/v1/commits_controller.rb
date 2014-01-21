module Api
  module V1
    class CommitsController < ApplicationController

      def index
        project = Project.find(params[:project_id])
        commits = project.repos.map(&:commits).flatten # :TODO: needs optimization
        render json: commits
      end

      def show
        commit = Commit.find(params[:id])
        render json: commit
      end

      def create
        repo = Repo.find_by(:gh_repo_id => repo_id_param)
        commit = repo.commits.new(:commit_hash => commit_id_param,
                                  :message => params[:message],
                                  :name => author[:name],
                                  :email => author[:email],
                                  :username => author[:username])
        if commit.save
          commit.repo.projects.map(&:id).each do |id|
            Pusher["project_#{id}"].trigger("github_notification", :data => commit.as_json)
          end
          render json: commit, :status => 201
        else
          render json: commit_errors(commit), :status => 422
        end
      end

      private

      def commit_errors(commit)
        messages = commit.errors.messages
        errors_hash = { "errors" => messages }
      end

      def repo_id_param
        params[:repository][:id]
      end

      def commit_id_param
        params[:commit_id][0...6]
      end

      def author
        @author_params ||= params[:author]
      end

    end
  end
end
