module Admin
  class BooksController < Admin::ApplicationController
    expose(:index_columns) { %w[id cover title published_on] }
    expose(:resource_collection) { Book.order("id desc") }
    expose(:resource, model: "Book")

    helper do
      def resource_name(book)
        book.title
      end

      def cover_column(book)
        if book.cover
          link_to image_tag(book.cover.thumb("x100").url), book.cover.url
        end
      end

      def published_on_column(book)
        l(book.published_on, format: "%b %Y")
      end
    end
  end
end
