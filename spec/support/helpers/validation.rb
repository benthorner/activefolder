RSpec::Matchers.define :fail_validation do |method|
  match do |subject|
    begin
      subject.send method; false
    rescue ActiveFolder::Model::ValidationError
      true
    end
  end
end

RSpec::Matchers.define :pass_validation do |method|
  match do |subject|
    subject.send method
  end
end
