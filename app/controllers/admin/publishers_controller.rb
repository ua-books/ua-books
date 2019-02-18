module Admin
  class PublishersController < Admin::ApplicationController
    expose(:index_columns) { %w[id name] }
    expose(:resource_collection) { Publisher.all }
    expose(:resource, model: "Publisher")

    helper do
      def resource_name(publisher)
        publisher.name
      end
    end

    def create
      resource.attributes = params_for_resource
      if resource.save
        current_user.update_attributes!(publisher: resource)
        redirect_to admin_books_path, notice: redirect_to_after_notice(:create)
      else
        render "new"
      end
    end
  end
end
