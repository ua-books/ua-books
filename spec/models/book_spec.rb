require "rails_helper"

RSpec.describe Book do
  describe "validations" do
    describe "#isbn" do
      specify "nil" do
        book = Book.new
        book.valid?
        expect(book.errors[:isbn]).to be_empty
        expect(book.isbn).to be_nil
      end

      specify "empty" do
        book = Book.new(isbn: "")
        book.valid?
        expect(book.errors[:isbn]).to be_empty
        expect(book.isbn).to eq ""
      end

      specify "valid normalized" do
        book = Book.new(isbn: "9786177538492")
        book.valid?
        expect(book.errors[:isbn]).to be_empty
        expect(book.isbn).to eq "9786177538492"
      end

      specify "valid pretty" do
        book = Book.new(isbn: "978-617-7538-49-2")
        book.valid?
        expect(book.errors[:isbn]).to be_empty
        expect(book.isbn).to eq "9786177538492"
      end

      specify "invalid" do
        book = Book.new(isbn: "9786177538497")
        book.valid?
        expect(book.errors[:isbn]).to eq ["is invalid"]
        expect(book.isbn).to eq "9786177538497"
      end
    end

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
