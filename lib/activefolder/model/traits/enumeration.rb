require 'activefolder/model/utilities/match'

module ActiveFolder
  module Model
    module Traits
      module Enumeration
        using Utilities::Match

        def find(name)
          results = all(name)
          results.count < 2 ? results.first : results
        end

        def find!(name)
          find(name) || (raise NotFoundError.new name)
        end

        def all(name = '*')
          query_suffix = File.join(model_name, name)
          query = File.join(model_base_dir, '**', query_suffix)

          paths = ActiveFolder.client.glob(path: query)
          paths.map { |path| model_class.load(path) }
        end

        def last; all.last end
        def first; all.first end

        def count; all.count end
        def to_a; all end

        def where(**args)
          all.select { |element| args.match(element) }
        end
      end
    end
  end
end
