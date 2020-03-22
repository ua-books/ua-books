class PublishersController < ApplicationController
  expose(:publisher)
  expose(:books) do
    publisher.books.published.preload(title_works: :person_alias)
  end
end
