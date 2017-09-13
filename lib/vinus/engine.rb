module Vinus
  class Engine < ::Rails::Engine
    isolate_namespace Vinus

    if Vinus.respond_to?(:root)
      config.autoload_paths << File.join(Vinus.root, 'lib')
      config.assets.precompile += [
        'vinus/sub.css',
        'vinus/printable.css'
      ]
    end

    # We don't want any automatic generators in the engine.
    config.generators do |g|
      g.orm             :active_record
      g.test_framework  false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end

    config.to_prepare do
      Dir.glob(Rails.root + 'app/decorators/**/*_decorator*.rb').each do |c|
        require_dependency(c)
      end
    end

    initializer 'vinus.initialize' do |app|
      # Add the default settings
      Vinus.add_settings_group :system_settings, [
        :store_name,
        :email_address,
        :currency_unit,
        :tax_name,
        :demo_mode
      ]

      # Add middleware
      app.config.middleware.use Vinus::SettingsLoader

      # Load our migrations into the application's db/migrate path
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end

      # Load view helpers for the base application
      ActiveSupport.on_load(:action_view) do
        require 'vinus/view_helpers'
        ActionView::Base.send :include, Vinus::ViewHelpers
      end

      ActiveSupport.on_load(:active_record) do
        require 'vinus/model_extension'
        ActiveRecord::Base.send :include, Vinus::ModelExtension
      end

      # Load default navigation
      require 'vinus/default_navigation'
    end

    generators do
      require 'vinus/setup_generator'
    end
  end
end
