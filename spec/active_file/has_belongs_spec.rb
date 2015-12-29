require 'spec_helper'

describe 'HasBelongs' do
  let(:subject) { build :model, name: 'model', base_dir: 'models' }
  let(:subject_path) { 'tmp/models/model' }

  describe '.has_many' do
    let(:fixture_path) { 'spec/support/fixtures/attributes.yaml' }

    let(:child) { subject.model_children.new(name: 'child') }
    let(:child_path) { File.join(subject_path, 'model_children/child') }

    before do
      FileUtils.mkdir_p(child_path)
      FileUtils.cp(fixture_path, child_path)
      child.load!
    end

    it 'creates a child collection' do
      children = subject.model_children.all
      expect(children.count).to eq 1

      expected = { meta: { key1: 'value1' },
                   data: { key2: 'value2' } }
      expect(children.first.attributes).to eq expected
    end
  end
end
