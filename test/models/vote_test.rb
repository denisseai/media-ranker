require "test_helper"

describe Vote do
  let (:new_user) {
    User.new(username: 'Fifi Grand')
  }
  let (:new_work) {
    Work.new(title: 'New book title', category: 'book', creator: "Author Name")
  }
  let (:new_vote) {
    Vote.new(user: new_user, work: new_work)
  }

  describe 'insta' do
    it "can be insta" do
      expect(new_vote.valid?).must_equal true
    end
    it 'will have the req field' do
      new_vote.save
      vote = Vote.first
      [:user, :work].each do |field|
        expect(vote).must_respond_to field
      end
    end
  end

  describe 'relationship' do
    it 'belongs to a user and a work' do
      vote = votes(:two)

      expect(vote.user).must_be_instance_of User
      expect(vote.work).must_be_instance_of Work
      expect(vote.user.username).must_equal 'Mushu Small'
      expect(vote.work.title).must_equal "Guardians of the Galaxy"
    
    end
  end

  describe 'validation' do
    it 'validates votes not voting on same work' do
      adding_vote = Vote.create(user_id: (users(:mushu).id), work_id:(works(:guardians).id))
      expect(adding_vote.valid?).must_equal false
    end
    it 'validates votes not voting on same work' do
      adding_vote = Vote.create(user_id: (users(:naya).id), work_id:(works(:guardians).id))
      expect(adding_vote.valid?).must_equal true
    end
  end
end