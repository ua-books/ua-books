module Admin
  class PublisherPolicy < Admin::ApplicationPolicy
    class Scope < Scope
      def resolve
        if user.admin?
          scope.all
        else
          scope.where(id: user.publisher_id)
        end
      end
    end

    def create?
      user.admin? || !user.publisher?
    end

    def update?
      user.admin? || user.publisher == record
    end
  end
end
