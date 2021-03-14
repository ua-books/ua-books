require "rails_helper"

RSpec.describe "/sitemap.xml" do
  specify "published book" do
    book = create(:book, :published, title: "Зубр шукає гніздо", updated_at: "2017-12-11", cover_uid: "dev/test.jpg")
    oksana = create(:author, first_name: "Оксана", last_name: "Була")
    create(:work, author_alias: oksana.main_alias, book: book)

    get sitemap_path

    expect(xml).to have_selector(:xpath, "//urlset/url")
    url = xml.find(:xpath, "//urlset/url")
    expect(url).to have_selector("loc", text: "http://www.example.com/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}")
    expect(url).to have_selector("changefreq", text: "always")
    expect(url).to have_selector("lastmod", text: "2017-12-11T00:00:00")
    expect(url).to have_selector("image")
    image = url.find("image")
    expect(image).to have_selector("loc", text: "dev/test.jpg")
    expect(image).to have_selector("title", text: "Обкладинка до книги «Зубр шукає гніздо»")
  end

  specify "published book w/o cover" do
    book = create(:book, :published)

    get sitemap_path

    expect(xml).to have_selector(:xpath, "//urlset/url")
    url = xml.find(:xpath, "//urlset/url")

    expect(url).to_not have_selector("image")
  end

  specify "draft book" do
    create(:book)

    get sitemap_path

    expect(xml).to_not have_selector(:xpath, "//urlset/url")
  end

  private

  def xml
    @xml ||= Capybara.string(response.body).tap do |xml|
      xml.native.remove_namespaces!
    end
  end
end
