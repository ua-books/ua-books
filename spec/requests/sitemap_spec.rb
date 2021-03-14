require "rails_helper"

RSpec.describe "/sitemap.xml" do
  specify "published book" do
    leva_publishing = create(:publisher, name: "Видавництво Лева")
    book = create(:book, :published, title: "Зубр шукає гніздо", updated_at: "2017-12-11", cover_uid: "dev/test.jpg", publisher: leva_publishing)
    leva_publishing.update!(updated_at: "2017-10-11") # override `Book belongs_to :publisher, touch: true` behavior
    oksana = create(:author, first_name: "Оксана", last_name: "Була")
    create(:work, author_alias: oksana.main_alias, book: book)

    get sitemap_path

    expect(xml).to have_selector("//urlset/url", count: 2)
    urls = xml.all(:xpath, "//urlset/url")

    book_url = urls[0]
    expect(book_url).to have_selector("loc", text: "http://www.example.com/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}")
    expect(book_url).to have_selector("changefreq", text: "always")
    expect(book_url).to have_selector("lastmod", text: "2017-12-11T00:00:00")
    expect(book_url).to have_selector("image")
    image = book_url.find("image")
    expect(image).to have_selector("loc", text: "dev/test.jpg")
    expect(image).to have_selector("title", text: "Обкладинка до книги «Зубр шукає гніздо»")

    publisher_url = urls[1]
    expect(publisher_url).to have_selector("loc", text: "http://www.example.com/#{CGI.escape "видавництво-лева"}/p/#{leva_publishing.id}")
    expect(publisher_url).to have_selector("changefreq", text: "always")
    expect(publisher_url).to have_selector("lastmod", text: "2017-10-11T00:00:00")
  end

  specify "published book w/o cover" do
    book = create(:book, :published)

    get sitemap_path

    urls = xml.all(:xpath, "//urlset/url")

    book_url = urls[0]
    expect(book_url).to be
    expect(book_url).to_not have_selector("image")
  end

  specify "draft book" do
    create(:book)

    get sitemap_path

    expect(xml).to_not have_selector(:xpath, "//urlset/url")
  end

  specify "multiple published books - one publisher" do
    leva_publishing = create(:publisher, name: "Видавництво Лева")
    create(:book, :published, publisher: leva_publishing)
    create(:book, :published, publisher: leva_publishing)

    get sitemap_path

    expect(xml).to have_selector("//url/loc", text: "http://www.example.com/#{CGI.escape "видавництво-лева"}/p/#{leva_publishing.id}", count: 1)
  end

  private

  def xml
    @xml ||= Capybara.string(response.body).tap do |xml|
      xml.native.remove_namespaces!
    end
  end
end
