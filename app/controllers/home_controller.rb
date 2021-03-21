class HomeController < ApplicationController
  expose(:books) do
    Book.published.recent_on_top.preload(Book.associations_to_preload)
  end
end
