module Admin
  class WorkPolicy < Admin::ApplicationPolicy
    class Scope < Scope
      def resolve
        if user.admin?
          scope.all
        else
          scope.joins(:book).where(books: {publisher_id: user.publisher_id})
        end
      end
    end

    def index?
      user.admin? || user.publisher?
    end

    def create?
      user.admin? || (record.book && user.publisher == record.book.publisher)
    end

    def update?
      create?
    end
  end
end
