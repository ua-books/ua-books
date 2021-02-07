module Admin
  class HomePolicy < Admin::ApplicationPolicy
    def show?
      user.admin? || user.publisher?
    end
  end
end
