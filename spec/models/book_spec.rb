require "rails_helper"

RSpec.describe Book do
  describe "validations" do
    describe "#publisher_page_url" do
      specify "nil" do
        book = Book.new
        book.valid?
        expect(book.errors[:publisher_page_url]).to be_empty
      end

      specify "empty" do
        book = Book.new(publisher_page_url: "")
        book.valid?
        expect(book.errors[:publisher_page_url]).to be_empty
      end

      specify "valid" do
        book = Book.new(publisher_page_url: "http://savchook.com")
        book.valid?
        expect(book.errors[:publisher_page_url]).to be_empty
      end

      specify "without protocol" do
        book = Book.new(publisher_page_url: "savchook.com")
        book.valid?
        expect(book.errors[:publisher_page_url]).to eq ["is invalid"]
      end

      specify "invalid" do
        book = Book.new(publisher_page_url: "http:// savchook.com")
        book.valid?
        expect(book.errors[:publisher_page_url]).to eq ["is invalid"]
      end

      specify "with trailing spaces" do
        book = Book.new(publisher_page_url: " http://savchook.com ")
        book.valid?
        expect(book.errors[:publisher_page_url]).to be_empty
        expect(book.publisher_page_url).to eq "http://savchook.com"
      end
    end
  end
end
