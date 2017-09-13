module Vinus
  class PaymentsController < ApplicationController
    before_filter { @order = Vinus::Order.find(params[:order_id]) }
    before_filter { params[:id] && @payment = @order.payments.find(params[:id]) }

    def create
      payment = @order.payments.build(params[:payment].permit(:amount, :method, :reference))
      if payment.save
        redirect_to @order, flash: { notice: t('vinus.payments.create_notice') }
      else
        redirect_to @order, flash: { alert: payment.errors.full_messages.to_sentence }
      end
    end

    def destroy
      @payment.destroy
      redirect_to @order, flash: { notice: t('vinus.payments.destroy_notice') }
    end

    def refund
      if request.post?
        @payment.refund!(params[:amount])
        redirect_to @order, flash: { notice: t('vinus.payments.refund_notice') }
      else
        render layout: false
      end
    rescue Vinus::Errors::RefundFailed => e
      redirect_to @order, flash: { alert: e.message }
    end
  end
end
