require "rails_helper"
require "faker"

RSpec.describe ProjectsController, type: :controller do
  login_user

  before(:all) do
    @project1 = build(:project, :with_tasks_and_comments)
    puts @project1.id
  end

  describe "Projects" do
    it " GET projects#index returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "GET projects#new a success response" do
      get :new
      expect(response).to be_successful
    end

    it "POST projects#create a success response" do
      post :new, params: {
        name: Faker::Lorem.sentence(word_count: 3),
        summary: Faker::Lorem.paragraph(sentence_count: 5),
        start_date: Faker::Date.between(from: 4.months.ago, to: 3.months.ago),
        end_date: Faker::Date.between(from: 2.months.ago, to: Date.today)
      }
      expect(response).to be_successful
    end
  end


end
