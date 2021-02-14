module Admin
  class AuthorsController < Admin::ApplicationController
    expose(:index_columns) { %w[id first_name last_name] }
    expose(:resource_collection) { Author.all }
    expose(:resource, model: "Author")

    helper do
      def resource_name(author)
        author_alias(author)
      end

      def index_action_columns
        %w[edit aliases]
      end

      def aliases_column(author)
        link_to "псевдоніми", admin_author_aliases_path(author_id: author), class: "button"
      end
    end
  end
end
