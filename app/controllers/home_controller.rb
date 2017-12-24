class HomeController < ApplicationController
  expose(:books) do
    Book.preload(title_works: :person_alias)
  end
end
