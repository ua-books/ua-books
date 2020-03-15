# A type of work a person did for a book.
# Examples: text author, illustrator, editor, corrector.
#
# If name is gender neutral, then both #name_feminine and #name_masculine
# are equal.
class WorkType < ApplicationRecord
  validates_presence_of :name_feminine, :name_masculine
  validates_uniqueness_of :name_feminine, :name_masculine
end
