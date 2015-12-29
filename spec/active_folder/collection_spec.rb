require 'spec_helper'

describe 'Collection' do
  describe '.create' do
    let!(:element) { Model.create(name: 'model') }

    it 'creates the specified element' do
      expect(Model.all).to eq [element]
    end
  end

  describe '.find_or_create' do
    let(:element) { build :model, name: 'model' }

    context 'when the element exists' do
      before { element.save! }

      it 'returns the existing element' do
        result = Model.find_or_create(name: 'model')
        expect(result).to eq element
      end
    end

    it 'creates a non-existing element' do
      result = Model.find_or_create(name: 'model')
      expect(result).to eq element
    end
  end
end
