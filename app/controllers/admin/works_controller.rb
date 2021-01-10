module Admin
  class WorksController < Admin::ApplicationController
    expose(:index_columns) { %w[id book type person_alias notes] }
    expose(:book) { params[:book_id].presence && Book.find(params[:book_id]) }
    expose(:resource_collection) do
      scope = Work.preload(:book, :type, person_alias: :author).order(:book_id, :person_alias_id)
      if book
        scope = scope.where(book_id: book.id)
      end
      scope
    end
    expose(:resource, model: "Work")

    helper do
      def resource_name(work)
        "#{work.book.title} - #{work_type_name(work)} - #{person_alias(work.person_alias)}"
      end

      def book_column(work)
        work.book.title
      end

      def type_column(work)
        work_type_name(work)
      end

      def person_alias_column(work)
        person_alias(work.person_alias)
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
