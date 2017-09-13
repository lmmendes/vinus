module Vinus
  class VendorsController < Vinus::ApplicationController
    before_filter { @active_nav = :vendors }
    before_filter { params[:id] && @vendor = Vinus::Vendor.find(params[:id]) }

    def index
      @query   = Vinus::Vendor.includes(:merchant).page(params[:page]).search(params[:q])
      @vendors = @query.result
    end

    def new
      @vendor = Vinus::Vendor.new
    end

    def create
      @vendor = Vinus::Vendor.new(safe_params)
      if @vendor.save
        redirect_to :vendors, flash: { notice: t('vinus.vendors.create_notice') }
      else
        render action: 'new'
      end
    end

    def edit
    end

    def update
      if @vendor.update(safe_params)
        redirect_to [:edit, @vendor], flash: { notice: t('vinus.vendors.update_notice') }
      else
        render action: 'edit'
      end
    end

    def destroy
      @vendor.destroy
      redirect_to :vendors, flash: { notice: t('vinus.vendors.destroy_notice') }
    end

    private
    def safe_params
      params[:vendor].permit(:name)
    end
  end
end
