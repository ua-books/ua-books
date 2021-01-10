module Admin
  class AuthorsController < Admin::ApplicationController
    expose(:index_columns) { %w[id first_name last_name] }
    expose(:resource_collection) { Author.all }
    expose(:resource, model: "Author")

    helper do
      def resource_name(author)
        author_alias(author)
      end
    end
  end
end
