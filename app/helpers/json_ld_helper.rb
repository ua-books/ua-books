module JsonLdHelper
  def book_as_json_ld(book)
    url = book_url(id: book, slug: nil)

    json = {
      "@context": "https://schema.org",
      "@type": "Book",
      "@id": url,
      "url": url,
      "name": book.title,
      "inLanguage": "uk",
      "numberOfPages": book.number_of_pages,
      "datePublished": book.published_on,
      "publisher": publisher_as_json_ld(book.publisher),
    }

    author_works = book.works.find_all(&:author?)
    if author_works.present?
      json[:author] = works_as_json_ld(author_works)
    end

    illustrator_works = book.works.find_all(&:illustrator?)
    if illustrator_works.present?
      json[:illustrator] = works_as_json_ld(illustrator_works)
    end

    editor_works = book.works.find_all(&:editor?)
    if editor_works.present?
      json[:editor] = works_as_json_ld(editor_works)
    end

    translator_works = book.works.find_all(&:translator?)
    if translator_works.present?
      json[:translator] = works_as_json_ld(translator_works)
    end

    contributor_works = book.works.find_all(&:contributor?)
    if contributor_works.present?
      json[:contributor] = works_as_json_ld(contributor_works)
    end

    if book.isbn.present?
      json[:isbn] = book.isbn
    end

    if book.cover_uid.present?
      json[:image] = imagekit_url(book.cover_uid, tr: {w: 640})
    end

    json
  end

  def publisher_as_json_ld(publisher)
    url = publisher_url(id: publisher, slug: nil)

    {
      "@type": "Organization",
      "@id": url,
      "url": url,
      "name": publisher_title(publisher),
    }
  end

  def works_as_json_ld(works)
    works.uniq { |work| work.author }.map { |work| work_as_json_ld(work) }
  end

  def work_as_json_ld(work)
    url = author_url(id: work.author, slug: nil)

    {
      "@type": "Person",
      "@id": url,
      "url": url,
      "name": author_alias(work.author),
    }
  end
end
