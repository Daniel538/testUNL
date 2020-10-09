require "rails_helper"
require "faker"

RSpec.describe Project, "validation", type: :model do

  before(:all) do
    @project1 = build(:project)
  end

  it "is valid with valid attributes" do
    expect(@project1).to be_valid
  end

  it "is not valid with name length less than 5" do
    project2 = build(:project, name: Faker::String.random(length: [0, 4]))
    expect(project2).to_not be_valid
  end

  it "is not valid with summary length less than 20" do
    project2 = build(:project, summary: Faker::String.random(length: [0, 19]))
    expect(project2).to_not be_valid
  end

  it "is not valid with end date before start date" do
    project2 = build(:project,
      start_date: Faker::Date.between(from: 2.months.ago, to: Date.today),
      end_date: Faker::Date.between(from: 4.months.ago, to: 3.months.ago))
    expect(project2).to_not be_valid
  end
end

RSpec.describe Project, "associations" do

  before(:all) do
    @project1 = build(:project, :with_tasks_and_comments)
  end

  it "is valid with valid with associations(list of tasks)" do
    expect(@project1).to be_valid
  end
end

