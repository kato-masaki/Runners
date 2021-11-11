FactoryBot.define do
  factory :diary do
    image_id { Faker::Number.number(2) }
    caption { Faker::Lorem.characters(number:30) }
    distance { Faker::Number.number(2) }
    hour { Faker::Number.number(2) }
    minute { Faker::Number.number(2) }
    second { Faker::Number.number(2) }
    pace_minute { Faker::Number.number(2) }
    pace_second { Faker::Number.number(2) }
    user
  end
end