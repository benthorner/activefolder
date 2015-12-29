require 'active_folder/model/utilities/matcher'

module ActiveFolder
  module Model
    module Traits
      module Enumeration
        using Utilities::Matcher

        def find(name)
          results = all(name)
          results.count < 2 ? results.first : results
        end

        def all(name = '*')
          element = File.join(model_name, name)
          query = File.join(model_base_dir, '**', element)

          paths = ActiveFolder.client.glob(path: query)
          paths.map { |path| model_class.load(path) }
        end

        def last
          all.last
        end

        def first
          all.first
        end

        def to_a
          all
        end

        def where(**args)
          all.select { |element| args.match(element) }
        end
      end
    end
  end
end
