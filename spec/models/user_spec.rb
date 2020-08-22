require 'rails_helper'

RSpec.describe User, type: :model do
  it "should has many bookings" do
    t = User.reflect_on_association(:bookings)
    expect(t.macro).to eq(:has_many)
  end
end
