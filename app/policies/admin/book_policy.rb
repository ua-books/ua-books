module Admin
  class BookPolicy < Admin::ApplicationPolicy
    class Scope < Scope
      def resolve
        if user.admin?
          scope.all
        else
          scope.where(publisher_id: user.publisher_id)
        end
      end
    end

    def index?
      user.admin? || user.publisher?
    end

    def new?
      user.admin? || (user.publisher? && (record.publisher.nil? || record.publisher == user.publisher))
    end

    def create?
      user.admin? || (record.publisher && record.publisher == user.publisher)
    end

    def update?
      create?
    end
  end
end
