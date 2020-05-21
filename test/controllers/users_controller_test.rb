require "test_helper"

describe UsersController do
  it "must get login_form" do
    get login_path
    must_respond_with :success
  end

  it "can login" do
    get user_path(users(:nena).id)
    must_respond_with :success
  end

  describe "loggin in" do
    it "can login a new user" do
      user = nil
      expect{
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "Grace Hoper"
    end

    it "can login an existing user" do
      expect{
        login("Nena Doxie")
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal (users(:nena).id)
    end
  end

  describe "current user" do
    it "can return the page if user is logged in" do
      # Arrange
      login()
      # Act
      get users_path
      # Assert
      must_respond_with :success
    end
  end

end
