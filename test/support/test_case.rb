# frozen_string_literal: true

class TestCase < Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
