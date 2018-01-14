module Admin
  module ApplicationHelper
    def index_title
      t("admin.#{controller_name}.index.title", default: controller_name.humanize)
    end

    def column_name(attribute)
      t("simple_form.labels.#{resource.model_name.singular}.#{attribute}", default: attribute.humanize)
    end
  end
end
