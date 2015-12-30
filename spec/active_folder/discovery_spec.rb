require 'spec_helper'

describe 'Discovery' do
  describe '.current' do
    let(:subject) { create :model }
    let(:child) { subject.model_children.create(name: 'child') }

    it 'returns the nearest instance' do
      expect(Model.current subject.path).to eq subject
      expect(Model.current child.path).to eq subject
    end
  end
end
