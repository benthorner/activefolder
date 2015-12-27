FactoryGirl.define do
  factory :active_file, class: ActiveFile::Base do
    name { Faker::Name.name }
    base_dir { Faker::Internet.slug }

    initialize_with do
      ActiveFile::Base.new(attributes)
    end
  end
end
