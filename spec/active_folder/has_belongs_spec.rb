require 'spec_helper'

describe 'HasBelongs' do

  describe '.has_many' do
    let(:subject) { build :model }
    let!(:child) { subject.model_children.create(name: 'child') }

    it 'creates a child collection' do
      expect(subject.model_children.all).to eq [child]
    end
  end

  describe '.belongs_to' do
    let(:subject) { create :model }
    let(:child) { subject.model_children.build(name: 'child') }

    it 'returns the nearest ancestor' do
      expect(child.model).to eq subject
    end
  end

  describe '.current' do
    let(:subject) { create :model }
    let(:child) { subject.model_children.create(name: 'child') }

    it 'returns the nearest instance' do
      expect(Model.current).to be_nil
      expect(Model.current subject.path).to eq subject
      expect(Model.current child.path).to eq subject
    end
  end
end
