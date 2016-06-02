require 'rails_helper'

RSpec.describe Contest, :type => :model do
  skip
  it "should have a valid factory" do
    expect(FactoryGirl.build(:contest).save)
  end
end
