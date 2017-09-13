module Vinus
  class CustomersController < Vinus::ApplicationController
    before_filter { @active_nav = :customers }
    before_filter { params[:id] && @customer = Vinus::Customer.find(params[:id]) }

    def index
      @query = Vinus::Customer.ordered.page(params[:page]).search(params[:q])
      @customers = @query.result
    end

    def new
      @customer = Vinus::Customer.new
    end

    def show
      @addresses = @customer.addresses.ordered.load
      @orders = @customer.orders.ordered.load
    end

    def create
      @customer = Vinus::Customer.new(safe_params)
      if @customer.save
        redirect_to @customer, flash: { notice: t('vinus.customers.created_successfully') }
      else
        render action: 'new'
      end
    end

    def update
      if @customer.update(safe_params)
        redirect_to @customer, flash: { notice: t('vinus.customers.updated_successfully') }
      else
        render action: 'edit'
      end
    end

    def destroy
      @customer.destroy
      redirect_to customers_path, flash: { notice: t('vinus.customers.deleted_successfully') }
    end

    def search
      index
      render action: 'index'
    end

    private

    def safe_params
      params[:customer].permit(:first_name, :last_name, :company, :email, :phone, :mobile)
    end
  end
end
