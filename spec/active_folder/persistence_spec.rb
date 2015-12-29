require 'spec_helper'

describe 'Persistence' do
  let(:fixture_path) { 'spec/support/fixtures/attributes.yaml' }

  let(:subject) { build :model, name: 'model', base_dir: '/models' }
  let(:subject_path) { 'tmp/models/model' }

  describe '#load!' do
    before do
      FileUtils.mkdir_p(subject_path)
      FileUtils.cp(fixture_path, subject_path)
      subject.load!
    end

    it 'loads the object attributes' do
      expect(subject.attributes).to eq(meta: { key1: 'value1' },
                                       data: { key2: 'value2' })
    end
  end

  describe '#save!' do
    let(:attributes_path) { File.join(subject_path, 'attributes.yaml') }

    before do
      subject.meta = { key1: 'value1' }
      subject.data = { key2: 'value2' }
      subject.save!
    end

    it 'persists the object attributes' do
      expect(File.read attributes_path).to eq File.read(fixture_path)
    end
  end
end
