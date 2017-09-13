module Vinus
  class SessionsController < Vinus::ApplicationController
    layout 'vinus/sub'
    skip_before_filter :login_required, only: [:new, :create]

    def create
      if user = Vinus::User.authenticate(params[:email_address], params[:password])
        session[:vinus_user_id] = user.id
        redirect_to :orders
      else
        flash.now[:alert] = t('vinus.sessions.create_alert')
        render action: 'new'
      end
    end

    def destroy
      session[:vinus_user_id] = nil
      redirect_to :login
    end
  end
end
