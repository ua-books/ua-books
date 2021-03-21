class AuthorsController < ApplicationController
  expose(:author)
  expose(:author_works) do
    author.published_works.preload(:type, book: Book.associations_to_preload)
  end

  def show
    if author_works.empty?
      raise ActiveRecord::RecordNotFound
    end
  end
end
