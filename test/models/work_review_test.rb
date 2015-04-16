require 'test_helper'

class WorkReviewTest < ActiveSupport::TestCase
  test "save" do
    w = work_reviews(:one).save
    assert w
  end
end
