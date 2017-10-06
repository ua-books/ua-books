module ApplicationHelper
  # Goes to /html/head/title
  def book_head_title(book)
    "«#{book.title}» на Українських книжках"
  end
end
