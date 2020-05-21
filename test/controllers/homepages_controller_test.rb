require "test_helper"

describe HomepagesController do
  it "goes home" do
    get root_path
    must_respond_with :success
  end
end
