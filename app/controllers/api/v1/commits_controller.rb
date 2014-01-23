module Api
  module V1
    class CommitsController < ApplicationController

      def index
        project = Project.find(params[:project_id])
        commits = project.repos.map(&:commits).flatten # :TODO: needs optimization
        render json: commits.as_json
      end

      def show
        commit = Commit.find(params[:id])
        render json: commit.as_json
      end

      def create
        repo = Repo.find_by(:gh_repo_id => repo_id_param)
        commit = repo.commits.new(:commit_hash => params[:commit_id],
                                  :message => params[:message],
                                  :name => author[:name],
                                  :email => author[:email],
                                  :username => author[:username])
        if commit.save
          push(commit)
          render json: commit.as_json, :status => 201
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

      def author
        @author_params ||= params[:author]
      end

      def push(commit)
        data = CommitSerializer.new commit
        commit.repo.projects.map(&:id).each do |id|
          Pusher["project_#{id}"].trigger("github_notification",
                                          :data => data.as_json)
        end
      end

    end
  end
end
