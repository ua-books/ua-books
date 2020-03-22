class Publisher < ApplicationRecord
  validates_presence_of :name

  has_many :books
end
