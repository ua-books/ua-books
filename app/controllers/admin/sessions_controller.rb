module Admin
  class SessionsController < Admin::ApplicationController
    skip_before_action :authenticate
  end
end
