module Vinus
  class AttachmentsController < Vinus::ApplicationController
    def destroy
      @attachment = Vinus::Attachment.find_by!(token: params[:id])
      @attachment.destroy
      respond_to do |wants|
        wants.html { redirect_to request.referer, notice: t('vinus.attachments.remove_notice') }
        wants.json { render status: 'complete' }
      end
    end
  end
end
