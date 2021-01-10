class HomeController < ApplicationController
  expose(:books) do
    Book.published.preload(title_works: :author_alias)
  end
end
