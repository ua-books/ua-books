class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  module Authentication
    extend ActiveSupport::Concern

    included do
      expose(:current_user) do
        User.find_by(id: cookies.encrypted[:user_id])
      end
    end
  end
  include Authentication
end
