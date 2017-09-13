require 'test_helper'

module Vinus
  class SettingsTest < ActiveSupport::TestCase
    setup do
      Vinus.reset_settings
    end

    test 'settings are automatically loaded' do
      assert_equal true, Vinus.settings.is_a?(Settings)
    end

    test 'defaults are loaded' do
      assert_equal 'Widgets Inc.', Vinus.settings.store_name
      assert_equal 'sales@example.com', Vinus.settings.email_address
    end

    test 'database settings can be loaded into a hash' do
      db_settings = Setting.to_hash
      assert_equal Hash, db_settings.class
      assert_equal true, db_settings.empty?
    end

    test 'database settings can be set from a hash' do
      new_settings = { 'store_name' => 'Another Store', 'email_address' => 'test@test.com' }
      assert Setting.update_from_hash(new_settings)
      assert_equal new_settings, Setting.to_hash
      assert_equal 'Another Store', Vinus.settings.store_name
      assert_equal 'test@test.com', Vinus.settings.email_address
    end
  end
end
