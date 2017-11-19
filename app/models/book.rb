class Book < ApplicationRecord
  validates_presence_of :title, :number_of_pages

  has_many :works, inverse_of: :book

  dragonfly_accessor :cover
end
