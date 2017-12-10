module Admin
  class WorkTypesController < Admin::ApplicationController
    expose(:index_columns) { %w[id name_feminine name_masculine] }
    expose(:resource_collection) { WorkType.all }
    expose(:resource, model: "WorkType")

    helper do
      def resource_name(work_type)
        work_type.name_masculine
      end
    end
  end
end
