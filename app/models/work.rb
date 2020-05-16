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

end
