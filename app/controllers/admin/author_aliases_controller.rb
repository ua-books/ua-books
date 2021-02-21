module Admin
  class AuthorAliasesController < Admin::ApplicationController
    expose(:index_columns) { %w[id author first_name last_name] }
    expose(:index_action_columns) { %w[edit set_as_main] }
    expose(:author) { params[:author_id].presence && Author.find(params[:author_id]) }
    expose(:resource_collection) do
      scope = AuthorAlias.preload(:author).order(:author_id)
      if author
        scope = scope.where(author_id: author)
      end
      scope
    end
    expose(:resource, model: "AuthorAlias")

    helper do
      def resource_name(aa)
        "#{author_alias(aa.author)} - #{author_alias(aa)}"
      end

      def author_column(aa)
        author_alias(aa.author)
      end

      def set_as_main_column(aa)
        if aa.main?
          tag.span "головний", class: "label secondary"
        else
          button_to "зробити головним", set_as_main_admin_author_alias_path(aa), class: "button secondary small"
        end
      end

      def page_title(action: self.action_name)
        if author
          t "admin.author_aliases.#{action}.title_for_author", author: author_alias(author)
        else
          super
        end
      end
    end

    def set_as_main
      resource.set_as_main
      redirect_back fallback_location: admin_author_aliases_path
    end

    def redirect_to_after(action)
      redirect_to admin_author_aliases_path(author_id: resource.author_id), notice: redirect_to_after_notice(action)
    end
  end
end
