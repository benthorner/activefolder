module ActiveFile
  module Traits
    module Persistence
      def load!
        attrs = ActiveFile.store.load(attributes_path)
        attrs.each { |key,value| self[key] = value }
      end

      def load
        self.load!
      end

      def save!
        ActiveFile.store.save(attributes_path, attributes)
      end

      def save
        self.save!
      end

      private

      def attributes_path
        File.join(path, 'attributes.yaml')
      end
    end
  end
end
