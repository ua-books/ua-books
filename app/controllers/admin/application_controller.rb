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

    helper do
      def index_action_columns
        %w[edit]
      end

      def edit_column(resource)
        link_to "правити", polymorphic_path([:admin, resource], action: :edit), class: "button"
      end
    end

    def new
      resource.attributes = params_for_resource
    end

    def create
      resource.attributes = params_for_resource
      if resource.save
        redirect_to_after(:create)
      else
        render "new"
      end
    end

    def update
      if resource.update_attributes(params_for_resource)
        redirect_to_after(:update)
      else
        render "edit"
      end
    end

    def params_for_resource
      param_key = resource.model_name.param_key
      params[param_key].try(:permit!) || {}
    end

    def redirect_to_after(action)
      redirect_to polymorphic_path([:admin, resource.class])
    end
  end
end
