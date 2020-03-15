class BooksController < ApplicationController
  expose(:book)
  expose(:draft_preview_allowed?) do
    current_user && Admin::BookPolicy.new(current_user, book).update?
  end

  def show
    if !(book.published? || draft_preview_allowed?)
      raise ActiveRecord::RecordNotFound
    end
  end
end
