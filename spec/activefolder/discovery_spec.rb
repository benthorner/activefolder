require 'spec_helper'

describe 'Discovery' do
  describe '.find_by_path' do
    let(:subject) { create :model }
    let(:child) { subject.model_children.create(name: 'child') }

    it 'returns the nearest object' do
      expect(Model.find_by_path subject.path).to eq subject
      expect(Model.find_by_path child.path).to eq subject
    end
  end
end
