require 'spec_helper'

describe 'Persistence' do
  let(:subject) { build :active_file }

  let(:fixture_path) { 'spec/support/fixtures/attributes.yaml' }
  let(:subject_path) { File.join('tmp', subject.path) }

  describe '#load!' do
    before do
      FileUtils.mkdir_p(subject_path)
      FileUtils.cp(fixture_path, subject_path)
      subject.load!
    end

    it 'loads the object attributes' do
      expected = { meta: { key1: 'value1' },
                   data: { key2: 'value2' } }
      expect(subject.attributes).to eq expected
    end
  end

  describe '#save!' do
    before do
      subject.meta = { key1: 'value1' }
      subject.data = { key2: 'value2' }
      subject.save!
    end

    it 'persists the object attributes' do
      actual = File.read(File.join(subject_path, 'attributes.yaml'))
      expect(File.read(fixture_path)).to eq actual
    end
  end
end
