require "test_helper"

describe User do
  let (:new_user) {
    User.new(username: "Nena")
  }

  it "represent as or by an instance" do
    expect(new_user.valid?).must_equal true
  end

  it "will need all fields with input to login" do
    new_user.save
    nena = User.first
    expect(nena).must_respond_to :username
  end

  describe "validation" do
    it 'valid username' do
      add_user = User.new(username: "New User")
      expect(add_user.valid?).must_equal true
    end

    it 'will not validate a user without username' do
      new_user.username = nil
      
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
    it "can create a new user" do
      user = User.create(username: "nena")
      is_valid = user.valid?
      assert(is_valid)
    end

    it "username can not be nil" do
      user = User.create(username: nil)
      is_valid = user.valid?
      refute(is_valid)
    end
    it "username can not be empty" do
      user = User.create(username: " ")
      is_valid = user.valid?
      refute(is_valid)
    end
  end

  describe 'relationships' do
    it 'has a list of votes' do
      nena = users(:nena)
      
      nena.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      expect(nena.votes.count).must_equal 3
    end
  end

end
