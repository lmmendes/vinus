module Vinus
  class MerchantsController < Vinus::ApplicationController
    before_filter { @active_nav = :merchants }

    def index
      @query    = Vinus::Merchant.page(params[:page]).search(params[:q])
      @merchants = @query.result
    end
  end
end
