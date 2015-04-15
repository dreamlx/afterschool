require 'test_helper'

class WorkReviewTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
    c = WorkReview.count
    assert_equal(1, c, 'err count')
    assert !work_reviews(:one).blank?
  end
end
