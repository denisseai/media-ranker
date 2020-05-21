require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(title: 'Transformers', category: 'movie')
  }
  describe 'init' do
    it 'can be init' do
      expect(new_work.valid?).must_equal true
    end
    
    it 'will be filled' do
      new_work.save
      work = Work.first
      [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
    end
  end

  describe 'relationship' do
    it 'multiple votes' do
      work = works(:guardians)
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      expect(work.votes.count).must_equal 4
    end
  end
 
end