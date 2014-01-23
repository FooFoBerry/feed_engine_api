require 'spec_helper'

describe Api::V1::TrackerEventsController do

  describe "#push" do
    it "should have Pusher push out data" do
      project = FactoryGirl.create(:project)
      tracker_project = FactoryGirl.create(:tracker_project,
                                           :project_id => project.id)
      tracker_event = FactoryGirl.create(:tracker_event,
                                    :tracker_project_id => tracker_project.id)
      data = TrackerEventSerializer.new tracker_event

      params = {
        :tracker_event => {
          :pt_project_id => tracker_project.pt_project_id,
          :story_url => tracker_event.story_url,
          :message   => tracker_event.message,
          :user_name => tracker_event.user_name,
          :kind => tracker_event.kind,
          :story_id => tracker_event.story_id,
          :change_type => tracker_event.change_type,
          :story_title => tracker_event.story_title,
          :user_initials => tracker_event.user_initials
        }
      }
      p_stub = double
      Pusher.stub(:[]).and_return p_stub

      p_stub.should_receive(:trigger)
      post :create, params
    end
  end

end
