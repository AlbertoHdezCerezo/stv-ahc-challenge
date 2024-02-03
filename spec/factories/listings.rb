FactoryBot.define do
  factory :listing do
    title { "MyString" }
    start_time { "2023-01-09 10:22:13" }
    end_time { "2023-01-09 10:22:13" }
    description { "MyText" }
    image_url { "MyString" }
    episode_number { 1 }
    season_number { 1 }
  end
end
