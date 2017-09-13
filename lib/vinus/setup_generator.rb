require 'rails/generators'
module Vinus
  class SetupGenerator < Rails::Generators::Base
    def create_route
      route 'mount Vinus::Engine => "/vinus"'
    end
  end
end
