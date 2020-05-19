class Work < ApplicationRecord
  # def all_categories
  #   unique_categories = []
  #   self.all.each do |work|
  #     if !unique_categories.include?(work.category)
  #       unique_categories << work.category
  #     end
  #   end
  #   return unique_categories
  # end

  validates :category, :creator, :publication_year, :description, presence: true
  validates :title, presence: true, uniqueness: true
  
  def self.top_books
    books = Work.where(category: "book")
    return books.sample(10)
  end

  def self.top_albums
    albums = Work.where(category: "album")
    return albums.sample(10)
  end

  def self.top_media
    return Work.all.sample
  end

  def self.top_movies
    movies = Work.where(category: "movie")
    return movies.sample(10)
  end
end
