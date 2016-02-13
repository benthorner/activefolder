# ActiveFolder

## A file system ORM based on ActiveRecord

ActiveFolder gives you programmatic access to the file system at a high level of abstraction, mapping objects to files, and relations to folders.

### Introduction

To get started, require the gem and you're ready to go!

    require 'activefolder'

Now create a model to interact with your database.

    class City < ActiveFolder::Base; end

    City.create(name: 'London')
    => #<City name="London", base_dir="/cities">

    City.all
    => [#<City name="London", base_dir="/cities">]

    Dir.glob('**/*')
    => ["cities", "cities/London", "cities/London/attributes.yaml"]

You can also define relationships between models.

    class Country < ActiveFolder::Base
      has_many :cities
    end

    uk = Country.create(name: 'UK')
    => #<Country name="UK", base_dir="/countries">

    uk.cities.create(name: "London")
    => #<City name="London", base_dir="/countries/uk/cities">

    uk.cities.all
    => [#<City name="London", base_dir="/countries/uk/cities">]

Read on for more details and examples.

### Configuration

ActiveFolder supports the following configuration.

    ActiveFolder.setup do |config|
      config.client.root_path = '.'    # (default) relative/absolute path
    end

### Usage

#### Enumeration

Assume the following elements.

    Country.create(name: 'UK', languages: ['English'], area: 0.24)
    Country.create(name: 'Canada', languages: ['English', 'French'], area: 9.99)
    Country.create(name: 'Argentina', languages: ['Spanish'], area: 2.78)

You can then do some simple queries.

    Country.all
    => [#<Country name="Argentina", ...>, #<Country name="Canada", ...>, #<Country name="UK", ...>]

    Country.first   # => #<Country name="Argentina", ...>
    Country.last   # => #<Country name="UK", ...>

    Country.find('UK')   # => #<Country name="UK", ...>
    Country.count   # => 3

    Country.find!('Australia')
    ActiveFolder::Model::NotFoundError: bar

You can also do complex queries.

    Country.where(name: /na/)
    => [#<Country name="Argentina", ...>, #<Country name="Canada", ...>]

    Country.where(area: 0..3)
    => [#<Country name="Argentina", ...>, #<Country name="UK", ...>]

    Country.where(name: /.*/, languages: ['English'])
    => [#<Country name="Canada", ...>, #<Country name="UK", ...>]

The next section has an example with deep nesting.

#### Relation

Here's a more complicated example.

    class Country < ActiveModel::Base
      has_many :cities
      has_many :streets
      has_one :currency
    end

    class City < ActiveModel::Base
      belongs_to :country
      has_many :streets
    end

    class Street < ActiveModel::Base
      belongs_to :city
      belongs_to :country
    end

    class Currency < ActiveModel::Base; end

This creates a 3-level hierarchy.

    uk = Country.create(name: 'UK')
    london = uk.cities.create(name: 'London')

    street = london.streets.create(name: 'Downing Street')
    lane = uk.streets.create(name: 'Country Lane')

    gbp = Currency.create(name: 'GBP')
    uk.currency = gbp

Queries are then scoped by level.

    uk.streets.all
    => [#<Street name="Downing Street", ...>, #<Street name="Country Lane", ...>]

    london.streets.all
    => [#<Street name="Downing Street", ...>]

    london.country => #<Country name="UK", ...>
    street.country => #<Country name="UK", ...>

    street.city => #<City name="London", ...>
    lane.city => nil

    uk.currency
    => #<Currency name="GBP", base_dir="/currencies">

Complex queries can go across relations.

    Country.where(streets: [{ name: 'Country Lane' }])
    => [#<Country name="UK", ...">]

    Country.where(cities: [streets: [{ name: /Downing/ }]}])
    => [#<Country name="UK", ...">]

#### Collection

Normal create/destroy is supported...

    Country.create(name: 'UK', area: 0.24)
    => #<Country name="UK", area=0.24, base_dir="/countries">

    Country.find_or_create(name: 'UK', languages: ['English'])
    => #<Country name="UK", area=0.24, base_dir="/countries">

    Country.create!(name: 'UK')
    ActiveFolder::Model::DuplicateError: UK

    Country.destroy_all
    => [#<Country name="UK", base_dir="/countries">]

...as well as build/initialize.

    Country.build(name: 'UK', area: 0.24)
    => #<Country name="UK", area=0.24, base_dir="/countries">

    Country.find_or_initialize(name: 'UK', languages: ['English'])
    => #<Country name="UK", languages=["English"], base_dir="/countries">

#### Validation

Validation works like `where` for a single attribute.

    class Country < ActiveFolder::Base
      validate :languages, ['English', 'Spanish']
    end

Each attribute can have multiple validations.

    class Country < ActiveFolder::Base
      validate :languages, Array, 'languages must be an array'
    end

#### Persistence

Each object can load/save its attributes.

    Country.create(name: 'UK', area: 0.24)
    => #<Country name="UK", area=0.24, base_dir="/countries">

    uk = Country.new(name: 'UK', base_dir: '/countries')
    => #<Country name="UK", base_dir="/countries">

    uk.load
    => #<Country name="UK", base_dir="/countries", area=0.24>

    uk.languages = ['English']; uk.save
    => #<Country name="UK", languages=["English"], ...>

You can also destroy and update objects.

    uk.update(area: 0.25) # The beginning of the empire
    => #<Country name="UK", area=0.25, ...>

    uk.destroy
    => ["./countries/UK"]

Objects attributes are stored as YAML.

#### Discovery

Discover an object's heritage...

    uk = Country.create(name: 'UK')
    london = uk.cities.create(name: 'London')

    london.path => '/countries/uk/cities/London'

    Country.find_by_path(london.path)
    => #<Country name="UK", ...>

Useful for command line programs.

### Testing

Keep your test directory clean...

    require 'activefolder/rspec'    # Cleanup around examples

Cleanup deletes the ActiveFolder root path.
