module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout "admin"

    if Rails.env.production?
      http_basic_authenticate_with(
        name: ENV.fetch("RAILS_ADMIN_NAME"),
        password: ENV.fetch("RAILS_ADMIN_PASSWORD"),
      )
    end

    # See also app/controllers/omniauth_sessions_controller
    module Authentication
      extend ActiveSupport::Concern

      included do
        expose(:current_user) do
          User.find_by(id: cookies.encrypted[:user_id])
        end

        before_action :authenticate
      end

      private

      def authenticate
        unless current_user
          flash[:alert] = I18n.t "admin.sessions.show.alert"

          # Survive double redirect: current page -> /admin/auth -> provider.
          # `request.env["omniauth.origin"]` can handle only single redirect.
          session[:return_to] = request.original_fullpath

          redirect_to admin_sessions_path
        end
      end
    end
    include Authentication

    module Attributes
      extend ActiveSupport::Concern

      included do
        before_action :assign_attributes, only: %i[new create edit update]
      end

      private

      # Some policies check not only current user attributes, but also a resource attributes.
      # That requires them to be assigned *before* `check_permissions` is executed.
      def assign_attributes
        resource.attributes = params_for_resource
      end

      def params_for_resource
        param_key = resource.model_name.param_key
        params[param_key].try(:permit!) || {}
      end
    end
    include Attributes

    module Authorization
      extend ActiveSupport::Concern

      included do
        include Pundit
        before_action :check_permissions
      end

      private

      def check_permissions
        authorize [:admin, resource]
      rescue Pundit::NotAuthorizedError => exception
        policy_key = exception.policy.model_name.i18n_key
        flash[:alert] = t "#{policy_key}.#{exception.query}", scope: "permission_denied", default: :default
        redirect_to admin_permission_denied_path
      end
    end
    include Authorization

    helper do
      def index_action_columns
        %w[edit]
      end

      def edit_column(resource)
        link_to "правити", polymorphic_path([:admin, resource], action: :edit), class: "button"
      end
    end

    def create
      if resource.save
        redirect_to_after(:create)
      else
        render "new"
      end
    end

    def update
      if resource.save
        redirect_to_after(:update)
      else
        render "edit"
      end
    end

    def redirect_to_after(action)
      redirect_to polymorphic_path([:admin, resource.class]), notice: redirect_to_after_notice(action)
    end

    def redirect_to_after_notice(action)
      I18n.t "admin.#{controller_name}.#{action}.notice", default: :"admin.application.#{action}.notice"
    end
  end
end
