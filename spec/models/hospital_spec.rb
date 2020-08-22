require 'rails_helper'

RSpec.describe Hospital, type: :model do
  it "should has many schedule" do
    t = Hospital.reflect_on_association(:schedules)
    expect(t.macro).to eq(:has_many)
  end
end
