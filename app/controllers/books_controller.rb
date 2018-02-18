class BooksController < ApplicationController
  expose(:book, scope: ->{ Book.published })
end
