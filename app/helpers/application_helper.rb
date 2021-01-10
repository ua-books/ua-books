module ApplicationHelper
  # `ActiveSupport::Inflector.parameterize` supports ASCII symbols only (non-ASCII should
  # be transliterated first). We don't want to transliterate for SEO reasons, thus we
  # duplicate the logic here with Unicode support.
  def parameterize(string)
    string.gsub(/[^\p{Alnum}']+/, "-").sub(/^-/, "").sub(/-$/, "").downcase
  end

  # With `:works` option you can make additional filtering/preloading of `book.works`
  # without passing the logic into the helper.
  def book_title(book, works: book.works)
    author_aliases = works.find_all(&:title?).uniq(&:author_alias_id).map do |work|
      author_alias(work.author_alias)
    end

    "#{author_aliases.join ", "} «#{book.title}»"
  end

  def book_meta_description(book)
    if book.description_md.present?
      first_paragraph, _ = book.description_md.split("\n\n", 2)
      strip_tags(markdown(first_paragraph)).chomp("\n")
    else
      "Книга «#{book.title}»"
    end
  end

  # Gender-aware work type name
  def work_type_name(work)
    case work.author.gender
    when "female" then work.type.name_feminine
    when "male" then work.type.name_masculine
    end
  end

  def author_alias(author_alias)
    "#{author_alias.first_name} #{author_alias.last_name}"
  end

  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true))

  def markdown(text)
    MARKDOWN.render(text || "").html_safe
  end

  def publisher_title(publisher)
    publisher_name = publisher.name

    if publisher_name.starts_with? "Видав"
      publisher_name
    else
      "Видавництво «#{publisher_name}»"
    end
  end
end
