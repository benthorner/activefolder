require 'spec_helper'

describe 'HasBelongs' do
  describe '.has_one' do
    let(:link_path) { 'tmp/models/model/model_sibling' }
    let(:sibling_path) { 'model_siblings/model_sibling' }

    let(:subject) do
      build :model, name: 'model', base_dir: '/models'
    end

    let(:sibling) do
      create :model_sibling, name: 'model_sibling',
        base_dir: 'model_siblings'
    end

    it 'links to another element' do
      expect(subject.model_sibling).to be_nil
      subject.model_sibling = sibling

      expect(subject.model_sibling).to eq sibling
      expect(File.read link_path).to eq sibling_path
    end
  end

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
end
