module Admin
  class BooksController < Admin::ApplicationController
    expose(:index_columns) { %w[id title] }
    expose(:resource_collection) { Book.all }
  end
end
