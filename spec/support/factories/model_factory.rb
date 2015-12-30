FactoryGirl.define do
  factory :model do
    name { Faker::Internet.user_name }
    base_dir { '/models' }
  end

  factory :model_sibling do
    name { Faker::Internet.user_name }
    base_dir { '/model_siblings' }
  end
end
