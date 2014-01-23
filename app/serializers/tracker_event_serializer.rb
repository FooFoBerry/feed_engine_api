class TrackerEventSerializer < ActiveModel::Serializer
  attributes :id, :story_url, :message, :kind, :user_name, :story_id,
             :change_type, :story_title, :user_initials, :creation_date

  def creation_date
    object.created_at.to_i * 1000
  end
end
