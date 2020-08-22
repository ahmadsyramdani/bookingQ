require 'rails_helper'

RSpec.describe Specialist, type: :model do
  it "should has many doctors" do
    t = Specialist.reflect_on_association(:doctors)
    expect(t.macro).to eq(:has_many)
  end
end
