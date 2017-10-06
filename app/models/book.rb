class Book < ApplicationRecord
  validates_presence_of :title

  has_many :works, inverse_of: :book
end
