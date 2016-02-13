require 'spec_helper'

describe ActiveFolder::Base do
  subject do
    described_class.create(name: 'base',
                           base_dir: '/bases')
  end

  describe "#save" do
    it 'validates base_dir is non-empty' do
      subject.base_dir = ''

      expect { subject.save }
        .to raise_error '"base_dir" must not be empty'
    end

    it 'validates name is non-empty' do
      subject.name = ''

      expect { subject.save }
        .to raise_error '"name" must not be empty'
    end

    it 'validates name has no slashes' do
      subject.name = 'parent/child'

      expect { subject.save }
        .to raise_error '"name" must not contain slashes'
    end
  end
end
