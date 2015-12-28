FactoryGirl.define do
  factory :active_file, class: ActiveFile::Base do
    name { Faker::Name.first_name }
    base_dir { Faker::Name.first_name.pluralize }

    initialize_with do
      ActiveFile::Base.new(attributes)
    end
  end
end
