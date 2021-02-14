module Admin
  class AuthorAliasPolicy < Admin::ApplicationPolicy
    class Scope < Scope
      def resolve
        if user.admin? || user.publisher?
          scope.all
        else
          scope.none
        end
      end
    end

    def index?
      user.admin? || user.publisher?
    end

    def create?
      user.admin? || user.publisher?
    end
  end
end
