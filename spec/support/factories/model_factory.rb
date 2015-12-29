FactoryGirl.define do
  factory :model do
    name { Faker::Internet.user_name }
    base_dir { '/models' }
  end
end
