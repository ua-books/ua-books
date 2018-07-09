module Admin
  class SessionsController < Admin::ApplicationController
    skip_before_action :authenticate
    skip_before_action :check_permissions
  end
end
