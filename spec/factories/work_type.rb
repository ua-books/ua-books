FactoryGirl.define do
  factory :work_type do
    factory :text_author_type do
      name_feminine "Авторка тексту"
      name_masculine "Автор тексту"
    end

    factory :illustrator_type do
      name_feminine "Ілюстраторка"
      name_masculine "Ілюстратор"
    end
  end
end
