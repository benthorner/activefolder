require 'spec_helper'

describe 'Enumeration' do
  let!(:elements) do
    [create(:model, name: 'model_1', base_dir: '/models'),
     create(:model, name: 'model_2', base_dir: '/nested/models')]
  end

  describe '.all' do
    it 'returns all elements' do
      expect(Model.all).to eq elements
    end
  end

  describe '.find' do
    it 'returns the matching element if found' do
      expect(Model.find('model_2')).to eq elements[1]
    end

    it 'returns nil when no element matches' do
      expect(Model.find('model')).to be_nil
    end

    it 'returns an array for multiple matches' do
      expect(Model.find('model_*')).to eq elements
    end
  end

  describe '.first' do
    it 'returns the first element if any' do
      expect(Model.first).to eq elements[0]
      expect(ModelChild.first).to be_nil
    end
  end

  describe '.last' do
    it 'returns the last element if any'do
      expect(Model.last).to eq elements[1]
      expect(ModelChild.last).to be_nil
    end
  end
end
