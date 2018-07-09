module Admin
  class ApplicationPolicy
    extend ActiveModel::Naming

    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      user.admin?
    end

    def show?
      user.admin?
    end

    def create?
      user.admin?
    end

    def new?
      create?
    end

    def update?
      user.admin?
    end

    def edit?
      update?
    end
  end
end
