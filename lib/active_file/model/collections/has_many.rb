module ActiveFile
  module Model
    module Collections
      class HasMany
        def initialize(owner, collection)
          @owner = owner; @collection = collection
          @model = collection.classify.constantize
        end

        def all
          params = { path: search_path }
          paths = ActiveFile.client.glob(params)
          paths.map { |path| load_from(path) }
        end

        private

        def load_from(path)
          params = { name: File.basename(path),
                     base_dir: File.dirname(path) }

          instance = @model.new(**params)
          instance.load; instance
        end

        def search_path
          File.join(@owner.path, '**', @collection, '*')
        end
      end
    end
  end
end
