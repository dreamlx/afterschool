require 'test_helper'

class HomeWorkTest < ActiveSupport::TestCase
  test "save" do
    hw = home_works(:one).save validate: false
    assert hw
  end
end
