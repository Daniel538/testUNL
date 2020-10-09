module ControllerSupport
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user, admin: true)
      sign_in user
    end
  end
end
