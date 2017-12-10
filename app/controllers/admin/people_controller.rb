module Admin
  class PeopleController < Admin::ApplicationController
    expose(:index_columns) { %w[id first_name last_name] }
    expose(:resource_collection) { Person.all }
    expose(:resource, model: "Person")

    helper do
      def resource_name(person)
        person_alias(person)
      end
    end
  end
end
