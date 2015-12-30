require 'spec_helper'

describe ActiveFolder::Metal::Connections::Git do
  subject { described_class.new(double :metal_config) }

  describe '#root_path' do
    it 'returns the repository path' do
      allow(Rugged::Repository).to receive(:discover)
        .with(Dir.pwd).and_return 'root_path'

      expect(subject.root_path).to eq 'root_path'
    end

    it 'errors when repository not found' do
      allow(Rugged::Repository).to receive(:discover)
        .with(Dir.pwd).and_raise Rugged::RepositoryError.new

      expect { subject.root_path }
        .to raise_error ActiveFolder::Metal::SystemError
    end
  end
end
