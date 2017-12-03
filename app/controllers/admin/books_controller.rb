module Admin
  class BooksController < Admin::ApplicationController
    expose(:index_columns) { %w[id title] }
    expose(:resource_collection) { Book.all }
    expose(:resource, model: "Book")

    helper do
      def resource_name(resource)
        resource.title
      end
    end
  end
end
