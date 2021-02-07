module Admin
  class UsersController < Admin::ApplicationController
    expose(:index_columns) { %w[email first_name last_name admin publisher] }
    expose(:index_action_columns) { %w[] }
    expose(:resource_collection) { User.preload(:publisher).order("id desc") }
    expose(:resource, model: "User")

    helper do
      def publisher_column(user)
        user.publisher&.name || "-"
      end
    end
  end
end
