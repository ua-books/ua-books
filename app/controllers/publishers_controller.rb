class PublishersController < ApplicationController
  expose(:publisher)
  expose(:publisher_books) do
    publisher.books.published.preload(title_works: :author_alias)
  end

  def show
    if publisher_books.empty?
      raise ActiveRecord::RecordNotFound
    end
  end
end
