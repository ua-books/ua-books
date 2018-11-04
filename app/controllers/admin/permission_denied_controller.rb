module Admin
  class PermissionDeniedController < Admin::ApplicationController
    skip_before_action :check_permissions
  end
end
