require "test_helper"

describe UsersController do
  it "must get login_form" do
    get users_login_form_url
    must_respond_with :success
  end

  it "must get login" do
    get users_login_url
    must_respond_with :success
  end

  it "can get login form" do
    get login_path
    must_respond_with :success
  end

  describe "loggin in" do
    it "can login a new user" do
      user = nil
      expect {
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.user_id
      expect(user.username).must_equal user_hash[:user][:username]
    end

    it "can login an existing user" do
      user = User.create(username: "Ed Sheeran")
      expect{
        login(user.username)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.user_id
    end
  end

  describe "logout" do
    it "can logout a logged in user" do
      login()
      expect(session[:user_id]).wont_be_nil

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end
end
