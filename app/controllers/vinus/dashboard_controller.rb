module Vinus
  class DashboardController < Vinus::ApplicationController
    def home
      redirect_to :orders
    end
  end
end
