module Admin
  class SessionsController < Admin::ApplicationController
    skip_before_action :authenticate
    skip_before_action :check_permissions

    def destroy
      cookies.delete(:user_id)
      redirect_back fallback_location: admin_books_path
    end
  end
end
