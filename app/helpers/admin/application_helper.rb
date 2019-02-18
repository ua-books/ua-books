module Admin
  module ApplicationHelper
    def page_title(action: self.action_name)
      t("admin.#{controller_name}.#{action}.title", default: controller_name.humanize)
    end

    def column_name(attribute)
      t("simple_form.labels.#{resource.model_name.singular}.#{attribute}", default: attribute.humanize)
    end
  end
end
