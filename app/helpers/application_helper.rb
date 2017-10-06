module ApplicationHelper
  # Goes to /html/head/title
  def book_head_title(book)
    "«#{book.title}» на Українських книжках"
  end

  # Gender-aware work type name
  def work_type_name(work)
    case work.person.gender
    when "female" then work.type.name_feminine
    when "male" then work.type.name_masculine
    end
  end

  def person_alias(person_alias)
    "#{person_alias.first_name} #{person_alias.last_name}"
  end
end
