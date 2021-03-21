class PublishersController < ApplicationController
  expose(:publisher)
  expose(:publisher_books) do
    publisher.books.published.preload(Book.associations_to_preload)
  end

  def show
    if publisher_books.empty?
      raise ActiveRecord::RecordNotFound
    end
  end
end
