require 'spec_helper'

describe 'HasBelongs' do
  let(:subject) { build :model, name: 'model', base_dir: '/models' }
  let(:subject_path) { 'tmp/models/model' }

  describe '.has_many' do
    let!(:child) { subject.model_children.create(name: 'child') }
    let(:child_path) { File.join(subject_path, 'model_children/child') }

    it 'creates a child collection' do
      expect(subject.model_children.all).to eq [child]
    end
  end
end
