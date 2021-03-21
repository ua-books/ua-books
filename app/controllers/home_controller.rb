class HomeController < ApplicationController
  expose(:books) do
    Book.published.preload(Book.associations_to_preload)
  end
end
