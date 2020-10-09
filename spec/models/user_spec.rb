require "rails_helper"
RSpec.describe User, "validation", type: :model do

  before(:all) do
    @user1 = build(:user)
  end

  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique email" do
    user2 = create(:user, email: "test@mail.ru")
    user3 = build(:user, email: "test@mail.ru")
    expect(user3).to_not be_valid
    user2.destroy
  end

  it "is not valid without a password" do
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without an email" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without first_name and last_name" do
    user2 = build(:user, first_name: nil)
    user3 = build(:user, last_name: nil)
    expect(user2).to_not be_valid
    expect(user3).to_not be_valid
  end

  it "get users full name" do
    expect(@user1.get_full_name.eql?(@user1.first_name + " " + @user1.last_name))
  end

end
