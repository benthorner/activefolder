FactoryGirl.define do
  factory :model do
    name { Faker::Name.first_name }
    base_dir { '.' }
  end
end
