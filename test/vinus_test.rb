require 'test_helper'

class VinusTest < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, Vinus
  end

  test 'root path is set' do
    assert_equal File.expand_path('../../', __FILE__), Vinus.root
  end
end
