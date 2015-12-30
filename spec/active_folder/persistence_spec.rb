require 'spec_helper'

describe 'Persistence' do
  let(:subject) do
    build :model, name: 'model', base_dir: '/models',
      meta: { key1: 'value1' }, data: { key2: 'value2' }
  end

  let(:fixture_path) { 'spec/support/fixtures/attributes.yaml' }
  let(:subject_path) { 'tmp/models/model' }
  let(:attributes_path) { File.join(subject_path, 'attributes.yaml') }

  describe '#load!' do
    before do
      FileUtils.mkdir_p(subject_path)
      FileUtils.cp(fixture_path, subject_path)
    end

    it 'loads the object attributes' do
      expect(subject.load!.attributes).to eq(meta: { key1: 'value1' },
                                             data: { key2: 'value2' })
    end
  end

  describe '#load' do
    before do
      FileUtils.mkdir_p(subject_path)
      FileUtils.cp(fixture_path, subject_path)
    end

    it 'loads the object attributes' do
      expect(subject.load.attributes).to eq(meta: { key1: 'value1' },
                                           data: { key2: 'value2' })
    end
  end

  describe '#save!' do
    it 'persists the object attributes' do
      expect(subject.save!).to eq subject
      expect(File.read attributes_path).to eq File.read(fixture_path)
    end
  end

  describe '#save' do
    it 'persists the object attributes' do
      expect(subject.save).to eq subject
      expect(File.read attributes_path).to eq File.read(fixture_path)
    end
  end

  describe '#update!' do
    before do
      subject.update!(meta: { key1: 'value1' }, data: { key2: 'value2' })
    end

    it 'persists the specified attributes' do
      expect(File.read attributes_path).to eq File.read(fixture_path)
    end
  end

  describe '#update' do
    before do
      subject.update(meta: { key1: 'value1' }, data: { key2: 'value2' })
    end

    it 'persists the specified attributes' do
      expect(File.read attributes_path).to eq File.read(fixture_path)
    end
  end
end
