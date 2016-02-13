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

  describe '.find!' do
    it 'returns the matching element if found' do
      expect(Model.find!('model_2')).to eq elements[1]
    end

    it 'returns nil when no element matches' do
      expect { Model.find!('model') }
        .to raise_error(ActiveFolder::Model::NotFoundError)
    end

    it 'returns an array for multiple matches' do
      expect(Model.find!('model_*')).to eq elements
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

  describe '.where' do
    let!(:child_elements) do
      [elements[0].model_children.create(name: 'child_1', id: 1),
       elements[1].model_children.create(name: 'child_2', id: 2)]
    end

    it 'filters by object equality' do
      results = Model.where(name: 'model_1')
      expect(results).to eq [elements[0]]
    end

    it 'filters by numeric range' do
      results = ModelChild.where(id: 1..2)
      expect(results).to eq child_elements
    end

    it 'filters by regular expression' do
      results = Model.where(name: /.*/)
      expect(results).to eq elements
    end

    it 'filters by class instance' do
      results = Model.where(name: String)
      expect(results).to eq elements
    end

    it 'filters by array inclusion' do
      results = ModelChild.where(id: [1])
      expect(results).to eq [child_elements[0]]

      results = Model.where(model_children: child_elements)
      expect(results).to eq elements
    end

    it 'filters by multiple attributes' do
      results = ModelChild.where(name: 'child_2', id: 2)
      expect(results).to eq [child_elements[1]]
    end

    it 'filters by recursion' do
      params = { model_children: [{ name: 'model_child_1' }] }
      expect(Model.where(**params)).to eq [elements[0]]
    end
  end

  describe '.count' do
    it 'returns the count of elements' do
      expect(Model.count).to eq elements.count
    end
  end
end
