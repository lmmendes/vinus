module Vinus
  class SettingsController < ApplicationController
    before_filter { @active_nav = :settings }

    def update
      if Vinus.settings.demo_mode?
        fail Vinus::Error, t('vinus.settings.demo_mode_error')
      end

      Vinus::Setting.update_from_hash(params[:settings].permit!)
      redirect_to :settings, notice: t('vinus.settings.update_notice')
    end
  end
end
