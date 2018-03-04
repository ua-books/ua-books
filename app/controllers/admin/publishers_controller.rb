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
  end
end
