# Fields:
#   "state" can be "draft" or "published".
#     It defines record visibility;
#
#   "publisher_page_url" (optional) contains URL to the
#     book on the publisher's site. Usually it's not the same
#     URL as for publisher's homepage;
#
#   "description_md" (optional) contains description/annotation
#     formatted with Markdown.
class Book < ApplicationRecord
  enum state: {
    draft: "draft",
    published: "published",
  }

  validates_presence_of :title, :number_of_pages, :publisher
  validate :publisher_page_url_should_be_valid, if: ->{ publisher_page_url.present? }

  belongs_to :publisher

  has_many :works, inverse_of: :book
  has_many :title_works, ->{ where(title: true) }, class_name: "Work"

  dragonfly_accessor :cover do
    default "public/system/dragonfly/no_image.png"
  end

  private

  def publisher_page_url_should_be_valid
    # Trailing spaces are too common when copy-pasting, be forgiving
    self.publisher_page_url = publisher_page_url.strip

    uri = URI.parse(publisher_page_url)
    if !uri.absolute?
      errors.add(:publisher_page_url, :invalid)
    end
  rescue
    errors.add(:publisher_page_url, :invalid)
  end
end
