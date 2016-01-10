require 'spec_helper'

describe 'Collection' do
  let(:block) { Proc.new { |model| model.id = 1 } }

  let(:element) do
    Model.new(name: 'model', base_dir: '/models', id: 1)
  end

  describe '.build' do
    it 'builds a new unsaved element' do
      result = Model.build(name: 'model', &block)
      expect(result).to eq element
      expect(Model.all).to be_empty
    end
  end

  describe '.create' do
    it 'creates the specified element' do
      result = Model.create(name: 'model', &block)
      expect(result).to eq element
      expect(Model.all).to eq [element]
    end
  end

  describe '.create!' do
    context 'when the element exists' do
      before do
        element.id = nil; element.save!
      end

      it 'raises a duplicate error' do
        expect { Model.create!(name: 'model', &block) }
          .to raise_error(ActiveFolder::Model::DuplicateError)
      end
    end

    it 'creates a non-existing element' do
      result = Model.create(name: 'model', &block)
      expect(result).to eq element
      expect(Model.all).to eq [element]
    end
  end

  describe '.find_or_create' do
    context 'when the element exists' do
      before do
        element.id = nil; element.save!
      end

      it 'returns the existing element' do
        result = Model.find_or_create(name: 'model', &block)
        expect(result).to eq element
      end
    end

    it 'creates a non-existing element' do
      result = Model.find_or_create(name: 'model', &block)
      expect(result).to eq element
      expect(Model.all).to eq [element]
    end
  end

  describe '.find_or_initialize' do
    context 'when the element exists' do
      before do
        element.id = nil; element.save!
      end

      it 'returns the existing element' do
        result = Model.find_or_initialize(name: 'model', &block)
        expect(result).to eq element
      end
    end

    it 'builds a non-existing element' do
      result = Model.find_or_initialize(name: 'model', &block)
      expect(result).to eq element
      expect(Model.all).to be_empty
    end
  end

  describe '.destroy_all' do
    it 'destroys all the elements' do
      element.save; Model.destroy_all
      expect(Model.all).to be_empty
    end
  end
end
