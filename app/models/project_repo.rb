class ProjectRepo < ActiveRecord::Base
  belongs_to :project
  belongs_to :repo
end
