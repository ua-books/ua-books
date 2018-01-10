module Admin
  module ApplicationHelper
    def index_title
      t("admin.#{controller_name}.index.title", default: controller_name.humanize)
    end
  end
end
