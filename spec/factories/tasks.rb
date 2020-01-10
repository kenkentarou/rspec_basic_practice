FactoryBot.define do
  factory :task do
    title { Faker::Book.title }
    status { :doing }
    user
  end
end
