require 'spec_helper'

describe ActiveFolder::Metal::Config do
  describe '#root_path' do
    context 'when set manually' do
      before { subject.root_path = 'manual_root_path' }

      it 'returns the specified path' do
        subject.root_path = 'manual_root_path'
        expect(subject.root_path).to eq 'manual_root_path'
      end
    end

    context 'when set to :git' do
      let(:repo) { double :repo, workdir: 'root_path' }

      before { subject.root_path = :git }

      it 'returns the repository path' do
        allow(Rugged::Repository).to receive(:discover)
          .with('.').and_return repo

        expect(subject.root_path).to eq 'root_path'
      end

      it 'errors when repository not found' do
        allow(Rugged::Repository).to receive(:discover)
          .and_raise Rugged::RepositoryError.new

        expect { subject.root_path }
          .to raise_error ActiveFolder::Metal::SystemError
      end
    end
  end
end
