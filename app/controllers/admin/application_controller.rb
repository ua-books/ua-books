module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout "admin"

    def update
      if resource.update_attributes(resource_params)
        redirect_to redirect_to_after(:update)
      else
        render "edit"
      end
    end

    def resource_params
      param_key = resource.model_name.param_key
      params[param_key].try(:permit!)
    end

    def redirect_to_after(action)
      polymorphic_path([:admin, resource.class])
    end
  end
end
