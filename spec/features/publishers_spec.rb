require "rails_helper"

RSpec.describe "PublishersController" do
  let(:leva_publishing) { create(:publisher, name: "Старий Лев") }

  specify "#show" do
    book = create(:book, :published, title: "Зубр шукає гніздо", publisher: leva_publishing)
    oksana = create(:author, first_name: "Оксана", last_name: "Була")
    create(:work, author_alias: oksana.main_alias, book: book)

    visit "/p/#{leva_publishing.id}"
    expect(page).to have_css :h1, text: /^Видавництво «Старий Лев»$/

    expect(page).to have_link("Оксана Була «Зубр шукає гніздо»", href: "/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}")

    expect(page.title).to eq "Видавництво «Старий Лев» на Українських книжках"
    expect(page).to have_css "link[rel='canonical'][href='http://www.example.com/#{CGI.escape "видавництво-старий-лев"}/p/#{leva_publishing.id}']", visible: false
  end

  specify "draft book from the same publisher" do
    create(:book, title: "Зубр шукає гніздо", publisher: leva_publishing)

    visit "/p/#{leva_publishing.id}"
    expect(page).to_not have_content("Зубр шукає гніздо")
  end

  specify "published book from another publisher" do
    create(:book, :published, title: "Зубр шукає гніздо")

    visit "/p/#{leva_publishing.id}"
    expect(page).to_not have_content("Зубр шукає гніздо")
  end
end