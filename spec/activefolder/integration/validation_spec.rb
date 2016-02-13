require 'spec_helper'

describe 'Validation' do
  let(:subject) do
    Class.new(ActiveFolder::Base)
      .create(name: 'model', base_dir: '/models')
  end

  [:load, :save].each do |method|
    describe "##{method}" do
      it 'validates by object equality' do
        subject.class.validate :attribute, 1

        subject.attribute = 1
        expect(subject).to pass_validation method
        subject.attribute = nil
        expect(subject).to fail_validation method
      end

      it 'validates by numeric range' do
        subject.class.validate :attribute, 1..2

        subject.attribute = 1
        expect(subject).to pass_validation method
        subject.attribute = nil
        expect(subject).to fail_validation method
        subject.attribute = 0
        expect(subject).to fail_validation method
      end

      it 'validates by regular expression' do
        subject.class.validate :attribute, /.+/

        subject.attribute = '1'
        expect(subject).to pass_validation method
        subject.attribute = nil
        expect(subject).to fail_validation method
        subject.attribute = ''
        expect(subject).to fail_validation method
      end

      it 'validates by class instance' do
        subject.class.validate :attribute, String

        subject.attribute = ''
        expect(subject).to pass_validation method
        subject.attribute = nil
        expect(subject).to fail_validation method
      end

      it 'validates by array inclusion' do
        subject.class.validate :attribute, [1, 4]

        subject.attribute = 4
        expect(subject).to pass_validation method
        subject.attribute = [3, 4]
        expect(subject).to pass_validation method
        subject.attribute = nil
        expect(subject).to fail_validation method
        subject.attribute = 3
        expect(subject).to fail_validation method
      end

      it 'validates by recursion' do
        subject.class.validate :attribute, { a: '1' }

        subject.attribute = { a: '1' }
        expect(subject).to pass_validation method
        subject.attribute = { a: '2' }
        expect(subject).to fail_validation method
      end
    end
  end
end
