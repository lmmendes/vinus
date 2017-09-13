require 'globalize'

module Vinus
  class VendorLocalisationsController < ApplicationController
    before_filter { @active_nav = :vendors }
    before_filter { @vendor = Vinus::Vendor.find(params[:vendor_id]) }
    before_filter { params[:id] && @localisation = @vendor.translations.find(params[:id]) }

    def index
      @localisations = @vendor.translations
    end

    def new
      @localisation = @vendor.translations.new
      render action: 'form'
    end

    def create
      if I18n.available_locales.include? safe_params[:locale].to_sym
        I18n.locale = safe_params[:locale].to_sym

        if @vendor.update(safe_params)
          I18n.locale = I18n.default_locale
          redirect_to [@vendor, :localisations], flash: { notice: t('vinus.localisations.localisation_created') }
        else
          render action: 'edit'
        end
      else
        redirect_to [@vendor, :localisations]
      end
    end

    def edit
      render action: 'form'
    end

    def update
      if @localisation.update(safe_params)
        redirect_to [@vendor, :localisations], notice: t('vinus.localisations.localisation_updated')
      else
        render action: 'form'
      end
    end

    def destroy
      @localisation.destroy
      redirect_to [@vendor, :localisations], notice: t('vinus.localisations.localisation_destroyed')
    end

    private

    def safe_params
      params[:vendor_translation].permit(:name, :locale, :permalink, :description)
    end
  end
end
