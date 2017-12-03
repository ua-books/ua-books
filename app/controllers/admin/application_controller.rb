module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout "admin"

    def create
      resource.attributes = params_for_resource
      if resource.save
        redirect_to redirect_to_after(:create)
      else
        render "new"
      end
    end

    def update
      if resource.update_attributes(params_for_resource)
        redirect_to redirect_to_after(:update)
      else
        render "edit"
      end
    end

    def params_for_resource
      param_key = resource.model_name.param_key
      params[param_key].try(:permit!)
    end

    def redirect_to_after(action)
      polymorphic_path([:admin, resource.class])
    end
  end
end
