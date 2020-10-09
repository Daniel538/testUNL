require "rails_helper"

RSpec.describe Comment, "validation", type: :model do

  before(:all) do
    @comment1 = build(:comment)
  end

  it "is valid with valid attributes" do
    expect(@comment1).to be_valid
  end

  it "is not valid with title length less than 3" do
    comment2 = build(:comment, text: Faker::String.random(length: [0, 2]))
    expect(comment2).to_not be_valid
  end

end
