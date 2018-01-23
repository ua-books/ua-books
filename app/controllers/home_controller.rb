class HomeController < ApplicationController
  expose(:books) do
    Book.published.preload(title_works: :person_alias)
  end
end
