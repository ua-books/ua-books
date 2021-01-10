module Admin
  class WorksController < Admin::ApplicationController
    expose(:index_columns) { %w[id book type author_alias notes] }
    expose(:book) { params[:book_id].presence && Book.find(params[:book_id]) }
    expose(:resource_collection) do
      scope = Work.preload(:book, :type, author_alias: :author).order(:book_id, :author_alias_id)
      if book
        scope = scope.where(book_id: book.id)
      end
      scope
    end
    expose(:resource, model: "Work")

    helper do
      def resource_name(work)
        "#{work.book.title} - #{work_type_name(work)} - #{author_alias(work.author_alias)}"
      end

      def book_column(work)
        work.book.title
      end

      def type_column(work)
        work_type_name(work)
      end

      def author_alias_column(work)
        author_alias(work.author_alias)
      end

      def page_title(action: self.action_name)
        if book
          t "admin.works.#{action}.title_for_book", title: book.title
        else
          super
        end
      end
    end

    def redirect_to_after(action)
      redirect_to admin_works_path(book_id: resource.book_id), notice: redirect_to_after_notice(action)
    end
  end
end
