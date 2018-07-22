module Admin
  class PermissionDeniedController < Admin::ApplicationController
    skip_before_action :check_permissions

    before_action do
      unless current_user.admin? || current_user.publisher?
        redirect_to new_admin_publisher_path
        flash[:notice] = I18n.t "admin.publishers.index.notice"
      end
    end
  end
end
