FactoryGirl.define do
  factory :work_type do
    factory :text_author_type do
      name_feminine "Авторка тексту"
      name_masculine "Автор тексту"
      schema_org_role "author"
    end

    factory :illustrator_type do
      name_feminine "Ілюстраторка"
      name_masculine "Ілюстратор"
      schema_org_role "illustrator"
    end

    factory :chief_editor_type do
      name_feminine "Головна редакторка"
      name_masculine "Головний редактор"
      schema_org_role "editor"
    end

    factory :en_translator_type do
      name_feminine "Переклала з англійської"
      name_masculine "Переклав з англійської"
      schema_org_role "contributor"
    end
  end
end
