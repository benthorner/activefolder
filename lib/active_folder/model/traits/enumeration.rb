module ActiveFolder
  module Model
    module Traits
      module Enumeration
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
      end
    end
  end
end
