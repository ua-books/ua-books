FactoryGirl.define do
  factory :book do
    title "Зубр шукає гніздо"
    description_md <<~txt
      Усіма важливими справами в лісі порядкують дивовижні туконі. Ось і зараз
      вони готуються відвідати звірів, які взимку лягають спати. Туконі
      вкладають їх у ліжечка і дбають, щоб нікому нічого не бракувало.

      Але є звірі, які взимку не сплять. Зубр звик блукати у снігах в пошуках
      їжі. Він навіть не підозрював, що можна спокійно собі дрімати в барлозі,
      коли надворі мороз. Допоки одного дня не зустрів ведмедя, який саме
      готувався заснути… Що вийшло з цієї зустрічі, а також про вміння слухати
      себе й інших, розповідає ця тепла й зворушлива історія про зубра - перша
      книжка серії оповідок про мешканців лісу.
    txt
    number_of_pages 32
    publisher

    trait :published do
      state "published"
    end

    trait :with_cover do
      cover_uid "dev/2020/03/01/10/37/34/3854b73e-af43-4901-9dba-74b51ed44274/Obklad.jpg"
    end
  end
end
