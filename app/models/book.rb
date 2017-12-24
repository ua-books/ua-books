class Book < ApplicationRecord
  validates_presence_of :title, :number_of_pages

  has_many :works, inverse_of: :book
  has_many :title_works, ->{ where(title: true) }, class_name: "Work"

  dragonfly_accessor :cover
end
