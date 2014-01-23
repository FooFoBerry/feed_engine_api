require 'spec_helper'

describe TrackerEventSerializer do
  it "should create the js creation date" do
    event        = FactoryGirl.create(:tracker_event)
    serializer   = TrackerEventSerializer.new(event)
    js_timestamp = event.created_at.to_i * 1000

    expect(serializer.attributes[:creation_date]).to eq js_timestamp
  end
end
