module Admin
  class BooksController < Admin::ApplicationController
    expose(:index_columns) { %w[id cover title published_on] }
    expose(:resource_collection) { Book.order("id desc") }
    expose(:resource, model: "Book")

    helper do
      def resource_name(resource)
        resource.title
      end

      def cover_column(resource)
        if resource.cover
          link_to image_tag(resource.cover.thumb("x100").url), resource.cover.url
        end
      end

      def published_on_column(resource)
        l(resource.published_on, format: "%b %Y")
      end
    end
  end
end
