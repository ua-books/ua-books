module Admin
  class UserPolicy < Admin::ApplicationPolicy
    def index?
      user.admin?
    end
  end
end
