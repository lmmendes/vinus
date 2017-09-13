module Vinus
  class UserMailer < ActionMailer::Base
    def new_password(user)
      @user = user
      mail from: Vinus.settings.outbound_email_address, to: user.email_address, subject: 'Your new Vinus password'
    end
  end
end
