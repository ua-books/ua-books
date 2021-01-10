require "factory_girl_rails"

text_author_type = FactoryGirl.create(:text_author_type)
illustrator_type = FactoryGirl.create(:illustrator_type)

oksana_bula = FactoryGirl.create(:author, first_name: "Оксана", last_name: "Була", gender: "female")

leva_publishing = FactoryGirl.create(:publisher, name: "Видавництво Старого Лева")

zubr = FactoryGirl.create(:book, title: "Зубр шукає гніздо", publisher: leva_publishing)
vedmid = FactoryGirl.create(:book, title: "Ведмідь не хоче спати", publisher: leva_publishing)

Work.create!(title: true, book: zubr, author_alias: oksana_bula.main_alias, type: text_author_type)
Work.create!(book: zubr, author_alias: oksana_bula.main_alias, type: illustrator_type)
Work.create!(title: true, book: vedmid, author_alias: oksana_bula.main_alias, type: text_author_type)
Work.create!(book: vedmid, author_alias: oksana_bula.main_alias, type: illustrator_type)

FactoryGirl.create(:admin, email: "admin@ua-books.test")
FactoryGirl.create(:user, email: "lev@ua-books.test", publisher: leva_publishing)
