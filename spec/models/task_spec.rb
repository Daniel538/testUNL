require "rails_helper"

RSpec.describe Task, "validation", type: :model do

  before(:all) do
    @task1 = build(:task)
  end

  it "is valid with valid attributes" do
    expect(@task1).to be_valid
  end

  it "is not valid with title length less than 6" do
    task2 = build(:task, title: Faker::String.random(length: [0, 5]))
    expect(task2).to_not be_valid
  end

  it "is not valid with description length less than 6" do
    task2 = build(:task, description: Faker::String.random(length: [0, 5]))
    expect(task2).to_not be_valid
  end

  it "is not valid with end date before start date" do
    task2 = build(:task, status: "TEST")
    expect(task2).to_not be_valid
  end
end

RSpec.describe Task, "associations" do

  before(:all) do
    @task1 = build(:task, :with_comments)
  end

  it "is valid with valid with associations(list of comments)" do
    expect(@task1).to be_valid
  end
end
