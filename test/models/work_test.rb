require "test_helper"

describe Work do
  # Arrange
  let (:work) {
    Work.new(
      category: 'book',
      title: 'Wake-up Cup',
      creator: 'Bobbie Aufderhar',
      publication_year: '1946',
      description: 'Eaque cum architecto et.'
    )
  }

  it "can be instantiated" do
    # Act
    result = @work.valid?

    # Assert
    expect(result).must_equal true
  end

  it "will have the required fields" do
    work.save
    new_work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(new_work).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a title" do
      work.title = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a category" do
      work.category = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a creator" do
      work.creator = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :creator
      expect(work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "must have a publication_year" do
      work.publication_year = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ["can't be blank"]
    end

    it "must have a description" do
      work.description = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :description
      expect(work.errors.messages[:description]).must_equal ["can't be blank"]
    end
  end

  describe "top of a specific media" do
    describe " > 10 " do
      before do
        10.times do
          Work.create(
            category: 'book', 
            title: 'Test Book',
            creator: 'Test Author',
            publication_year: '2020',
            description: "I'm a the description of this book.",
          )
        end

        10.times do
          Work.create(
            category: 'album', 
            title: 'Test album',
            creator: 'Test Author',
            publication_year: '2020',
            description: "I'm a the description of this album.",
          )
        end

        10.times do
          Work.create(
            category: 'movie', 
            title: 'Test movie',
            creator: 'Test Author',
            publication_year: '2020',
            description: "I'm a the description of this movie.",
          )
        end
      end

      it "for books" do
        expect(Work.top_books.length).must_equal 10
      end

      it "for albums" do
        expect(Work.top_albums.length).must_equal 10
      end

      it "for movies" do
        expect(Work.top_movies.length).must_equal 10
      end

    end

    describe " < 10 " do
      it "for books" do
        expect(Work.top_books.length).must_equal 2
      end

      it "for albums" do
        expect(Work.top_albums.length).must_equal 2
      end

      it "for movies" do
        expect(Work.top_movies.length).must_equal 2
      end
    end


    describe "no works" do
      before do
        6.times do
          Work.destroy(Work.first.id)
        end
      end

      it "for books" do
        expect(Work.top_books.length).must_equal 0
      end

      it "for albums" do
        expect(Work.top_albums.length).must_equal 0
      end

      it "for movies" do
        expect(Work.top_movies.length).must_equal 0
      end
      
    end

  end

end