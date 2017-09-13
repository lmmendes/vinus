module Vinus
  class SettingsLoader
    def initialize(app)
      @app = app
    end

    def call(env)
      Vinus.reset_settings
      @app.call(env)
    ensure
      Vinus.reset_settings
    end
  end
end
