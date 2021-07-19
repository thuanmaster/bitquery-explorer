class Openchain::Trc20tokenController < Openchain::AddressController

  before_action :is_native

  def smart_contract
    render 'openchain/smart_contract/show'
  end

  def methods
    render 'openchain/smart_contract/methods'
  end

  def events
    render 'openchain/smart_contract/events'
  end

  def transactions
    render 'openchain/smart_contract/transactions'
  end

  def inflow
    render 'openchain/address/inflow'
  end

  def outflow
    render 'openchain/address/outflow'
  end

  def calls_contracts
    render 'openchain/address/calls_contracts'
  end

  private

  def is_native
    @token = params[:address]
    @native_token = native_token?
    @token_info = !@native_token && @info.smart_contract.currency
  end

  def native_token?
    @address == @network[:currency]
  end

  def redirect_by_type
    return if native_token?
    if !(sc = @info.try(:smart_contract))
      change_controller!  'openchain/address'
    elsif !sc.try(:currency)
      change_controller! 'openchain/smart_contract'
    end
  end

end
