require 'coffee-rails'
require 'sass-rails'
require 'jquery-rails'
require 'haml'
require 'bcrypt'
require 'dynamic_form'
require 'kaminari'
require 'ransack'
require 'globalize'

require 'nifty/utils'
require 'nifty/key_value_store'
require 'nifty/dialog'
require 'carrierwave'

module Vinus
  class << self
    # The path to the root of the Vinus application
    #
    # @return [String]
    def root
      File.expand_path('../../', __FILE__)
    end

    # Vinus settings as configured in the database
    #
    # @return [Vinus::Settings]
    def settings
      Thread.current[:vinus_settings] ||= Vinus::Settings.new(Vinus::Setting.to_hash)
    end

    # Clears the settings from the thread cache so they will be taken
    # from the database on next access
    #
    # @return [NilClass]
    def reset_settings
      Thread.current[:vinus_settings] = nil
    end

    # Defines a new set of settings which should be configrable from the settings page
    # in the Vinus UI.
    def add_settings_group(group, fields = [])
      settings_groups[group]  ||= []
      settings_groups[group]    = settings_groups[group] | fields
    end

    # All settings groups which are available for configuration on the settings page.
    #
    # @return [Hash]
    def settings_groups
      @settings_groups ||= {}
    end
  end
end

# Start your engines.
require 'vinus/engine'
