module Admin
  class WorksController < Admin::ApplicationController
    expose(:index_columns) { %w[id book type person_alias notes] }
    expose(:resource_collection) { Work.preload(:book, :type, person_alias: :person).order(:book_id, :person_alias_id) }
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
    end
  end
end
