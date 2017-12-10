module Admin
  class BooksController < Admin::ApplicationController
    expose(:index_columns) { %w[id title published_on] }
    expose(:resource_collection) { Book.order("id desc") }
    expose(:resource, model: "Book")

    helper do
      def resource_name(resource)
        resource.title
      end

      def published_on_column(resource)
        l(resource.published_on, format: "%b %Y")
      end
    end
  end
end
