module Vinus
  class UsersController < Vinus::ApplicationController
    before_filter { @active_nav = :users }
    before_filter { params[:id] && @user = Vinus::User.find(params[:id]) }
    before_filter(only: [:create, :update, :destroy]) do
      if Vinus.settings.demo_mode?
        fail Vinus::Error, t('vinus.users.demo_mode_error')
      end
    end

    def index
      @users = Vinus::User.all
    end

    def new
      @user = Vinus::User.new
    end

    def create
      @user = Vinus::User.new(safe_params)
      if @user.save
        redirect_to :users, flash: { notice: t('vinus.users.create_notice') }
      else
        render action: 'new'
      end
    end

    def edit
    end

    def update
      if @user.update(safe_params)
        redirect_to [:edit, @user], flash: { notice: t('vinus.users.update_notice') }
      else
        render action: 'edit'
      end
    end

    def destroy
      fail Vinus::Error, t('vinus.users.self_remove_error') if @user == current_user
      @user.destroy
      redirect_to :users, flash: { notice: t('vinus.users.destroy_notice') }
    end

    private

    def safe_params
      params[:user].permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
    end
  end
end
