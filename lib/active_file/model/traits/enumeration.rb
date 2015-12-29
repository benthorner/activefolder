module ActiveFile
  module Model
    module Traits
      module Enumeration
        def find(name)
          results = all(name)
          results.one? ? results.first : results
        end

        def all(name = '*')
          query = File.join(model_base_dir, '**', model_name, name)
          paths = ActiveFile.client.glob(path: query)
          paths.lazy.map { |path| model_class.load(path) }
        end
      end
    end
  end
end
