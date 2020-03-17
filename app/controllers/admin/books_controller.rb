module Admin
  class BooksController < Admin::ApplicationController
    expose(:index_columns) { %w[id state cover_url title published_on] }
    expose(:resource_collection) { Book.order("id desc") }
    expose(:resource, model: "Book")

    helper do
      def resource_name(book)
        book.title
      end

      def index_action_columns
        %w[edit works]
      end

      def state_column(book)
        link_to t("simple_form.options.book.state.#{book.state}"), book_path(id: book), target: "_blank"
      end

      def cover_url_column(book)
        if book.cover_uid?
          link_to imagekit_hd_image_tag(book.cover_uid, tr: {w: 100}), imagekit_url(book.cover_uid)
        end
      end

      def title_column(book)
        link_to_if book.publisher_page_url.present?, book.title, book.publisher_page_url
      end

      def published_on_column(book)
        l(book.published_on, format: "%b %Y")
      end

      def works_column(book)
        link_to "роботи", admin_works_path(book_id: book.id), class: "button"
      end
    end

    def redirect_to_after(action)
      if action == :create
        redirect_to admin_works_path(book_id: resource.id), notice: redirect_to_after_notice(:create)
      else
        super
      end
    end
  end
end
