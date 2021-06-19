FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    content { Faker::Sports::Football.player }
  end
end
