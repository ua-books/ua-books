# Links authors (via aliases) with books.
# An author can easily be a text author for a certain book
# and at the same time to be a translator for another one. It's not
# unusual to even mix roles within one book (for example, to be
# a text author and an illustrator).
#
# If #title is true, than an author of this work should appear in
# the book title. For example, you want text author name to be in a title,
# but omit editor's name. This option doesn't affect rendering of a full list
# of people worked on the book project.
class Work < ApplicationRecord
  belongs_to :book, inverse_of: :works
  belongs_to :type, class_name: "WorkType", foreign_key: "work_type_id"
  belongs_to :author_alias, inverse_of: :works, touch: true

  has_one :author, through: :author_alias

  validates_uniqueness_of :book_id, scope: [:author_alias_id, :work_type_id]

  delegate :author?, :editor?, :translator?, :illustrator?, :contributor?, to: :type

  def self.associations_to_preload
    [:type, :author_alias, :author]
  end
end
