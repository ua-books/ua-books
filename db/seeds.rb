require "factory_girl_rails"

text_author_type = FactoryGirl.create(:text_author_type)
illustrator_type = FactoryGirl.create(:illustrator_type)

oksana_bula = FactoryGirl.create(:person, :with_alias, first_name: "Оксана", last_name: "Була", gender: "female")

zubr = FactoryGirl.create(:book, title: "Зубр шукає гніздо")
vedmid = FactoryGirl.create(:book, title: "Ведмідь не хоче спати")

Work.create!(title: true, book: zubr, person_alias: oksana_bula.main_alias, type: text_author_type)
Work.create!(book: zubr, person_alias: oksana_bula.main_alias, type: illustrator_type)
Work.create!(title: true, book: vedmid, person_alias: oksana_bula.main_alias, type: text_author_type)
Work.create!(book: vedmid, person_alias: oksana_bula.main_alias, type: illustrator_type)
